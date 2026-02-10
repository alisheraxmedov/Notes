import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:notes/data/local/database.dart';
import 'package:drift/drift.dart';
import 'package:notes/core/const/api_constants.dart';

class GoogleDriveService {
  static const _backupFileName = ApiConstants.driveBackupFileName;
  static const _appFolderName = ApiConstants.driveAppFolderName;
  static const _baseUrl = ApiConstants.driveBaseUrl;
  static const _uploadUrl = ApiConstants.driveUploadUrl;

  final AppDatabase _db;
  final Dio _dio = Dio();
  String? _authToken;
  String? _folderId;

  GoogleDriveService(this._db);

  void setAuthToken(String token) {
    _authToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  //================================================================================
  //=============================== SYNC LOGIC =====================================
  //================================================================================

  /// Syncs local notes with Google Drive.
  Future<void> syncNotes() async {
    if (_authToken == null) throw Exception('Not authenticated');

    try {
      await _ensureBackupFolder();

      final localNotes = await _db.select(_db.notes).get();
      final cloudNotes = await _downloadBackup();

      final mergedNotes = await compute(
        _mergeNotesIsolate,
        _MergeParams(
          local: localNotes.map((n) => _noteToMap(n)).toList(),
          cloud: cloudNotes,
        ),
      );

      await _uploadBackup(mergedNotes);
      await _updateLocalDb(mergedNotes);
    } on DioException catch (e) {
      debugPrint('GoogleDriveService: Sync error (Dio): ${e.message}');
      if (e.response != null) {
        debugPrint('GoogleDriveService: Response data: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      debugPrint('GoogleDriveService: Sync error: $e');
      rethrow;
    }
  }

  //================================================================================
  //=============================== DRIVE API METHODS ==============================
  //================================================================================

  Future<void> _ensureBackupFolder() async {
    final query =
        "name='$_appFolderName' and mimeType='application/vnd.google-apps.folder' and trashed=false";
    final response =
        await _dio.get('$_baseUrl/files', queryParameters: {'q': query});

    final files = response.data['files'] as List;
    if (files.isNotEmpty) {
      _folderId = files.first['id'];
    } else {
      final createResponse = await _dio.post(
        '$_baseUrl/files',
        data: {
          'name': _appFolderName,
          'mimeType': 'application/vnd.google-apps.folder',
        },
      );
      _folderId = createResponse.data['id'];
    }
  }

  Future<List<Map<String, dynamic>>> _downloadBackup() async {
    if (_folderId == null) return [];

    final query =
        "name='$_backupFileName' and '$_folderId' in parents and trashed=false";
    final listResponse =
        await _dio.get('$_baseUrl/files', queryParameters: {'q': query});

    final files = listResponse.data['files'] as List;
    if (files.isEmpty) return [];

    final fileId = files.first['id'];
    final downloadResponse = await _dio.get(
      '$_baseUrl/files/$fileId',
      queryParameters: {'alt': 'media'},
      options: Options(responseType: ResponseType.bytes),
    );

    final responseData = downloadResponse.data;
    if (responseData is! List<int>) {
      throw Exception('Unexpected response type');
    }

    return await compute(_parseJsonIsolate, responseData);
  }

  Future<void> _uploadBackup(List<Map<String, dynamic>> notes) async {
    if (_folderId == null) return;

    final fileContent = await compute(_encodeJsonIsolate, notes);

    final query =
        "name='$_backupFileName' and '$_folderId' in parents and trashed=false";
    final listResponse =
        await _dio.get('$_baseUrl/files', queryParameters: {'q': query});
    final files = listResponse.data['files'] as List;

    final Map<String, dynamic> metadata;
    final String url;
    final String method;
    String? fileId;

    if (files.isNotEmpty) {
      fileId = files.first['id'];
      metadata = {
        'name': _backupFileName,
        'mimeType': 'application/json',
      };
      url = '$_uploadUrl/files/$fileId?uploadType=multipart';
      method = 'PATCH';
    } else {
      metadata = {
        'name': _backupFileName,
        'parents': [_folderId],
        'mimeType': 'application/json',
      };
      url = '$_uploadUrl/files?uploadType=multipart';
      method = 'POST';
    }

    final formData = FormData.fromMap({
      'metadata': MultipartFile.fromBytes(
        utf8.encode(jsonEncode(metadata)),
        contentType: MediaType('application', 'json'),
      ),
      'file': MultipartFile.fromBytes(
        fileContent,
        contentType: MediaType('application', 'json'),
      ),
    });

    if (method == 'PATCH') {
      await _dio.patch(url, data: formData);
    } else {
      await _dio.post(url, data: formData);
    }
  }

  //================================================================================
  //=============================== LOCAL DB HELPER ================================
  //================================================================================

  Future<void> _updateLocalDb(List<Map<String, dynamic>> notes) async {
    await _db.transaction(() async {
      for (final noteData in notes) {
        final existingQuery = _db.select(_db.notes)
          ..where((t) => t.title.equals(noteData['title']))
          ..where((t) => t.created.equals(DateTime.parse(noteData['created'])));

        final existing = await existingQuery.getSingleOrNull();

        if (existing == null) {
          await _db.into(_db.notes).insert(NotesCompanion.insert(
                title: noteData['title'],
                content: noteData['content'],
                date: noteData['date'],
                time: noteData['time'],
                nDate: Value(noteData['nDate']),
                nTime: Value(noteData['nTime']),
                today: Value(noteData['today']),
                created: Value(DateTime.tryParse(noteData['created'] ?? '') ??
                    DateTime.now()),
                updated: Value(DateTime.tryParse(noteData['updated'] ?? '')),
              ));
        }
      }
    });
  }

  static Map<String, dynamic> _noteToMap(Note note) => {
        'title': note.title,
        'content': note.content,
        'date': note.date,
        'time': note.time,
        'nDate': note.nDate,
        'nTime': note.nTime,
        'today': note.today,
        'created': note.created.toIso8601String(),
        'updated': note.updated?.toIso8601String(),
      };
}

//================================================================================
//=============================== ISOLATE HELPERS ================================
//================================================================================

class _MergeParams {
  final List<Map<String, dynamic>> local;
  final List<Map<String, dynamic>> cloud;

  _MergeParams({required this.local, required this.cloud});
}

List<Map<String, dynamic>> _mergeNotesIsolate(_MergeParams params) {
  final Map<String, Map<String, dynamic>> merged = {};

  for (final note in params.cloud) {
    final key = '${note['title']}_${note['created']}';
    merged[key] = note;
  }

  for (final note in params.local) {
    final key = '${note['title']}_${note['created']}';
    final existing = merged[key];

    if (existing == null) {
      merged[key] = note;
    } else {
      final localUpdated =
          DateTime.tryParse(note['updated'] ?? note['created']) ??
              DateTime(2000);
      final cloudUpdated =
          DateTime.tryParse(existing['updated'] ?? existing['created'] ?? '') ??
              DateTime(2000);

      if (localUpdated.isAfter(cloudUpdated)) {
        merged[key] = note;
      }
    }
  }

  return merged.values.toList();
}

List<Map<String, dynamic>> _parseJsonIsolate(List<int> bytes) {
  final jsonStr = utf8.decode(bytes);
  return List<Map<String, dynamic>>.from(jsonDecode(jsonStr));
}

List<int> _encodeJsonIsolate(List<Map<String, dynamic>> notes) {
  final jsonStr = jsonEncode(notes);
  return utf8.encode(jsonStr);
}
