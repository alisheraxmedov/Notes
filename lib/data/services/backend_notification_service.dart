import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:notes/data/local/database.dart';
import 'package:notes/data/services/notification_service.dart';

import 'package:notes/core/const/api_constants.dart';

class BackendNotificationService {
  static const String _baseUrl = ApiConstants.notificationBaseUrl;

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
    headers: {"Content-Type": "application/json"},
  ));

  static Future<bool> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    int? noteId,
  }) async {
    final fcmToken = NotificationService.fcmToken;
    final db = Get.find<AppDatabase>();
    final apiKey = await db.getApiKey();

    if (apiKey == null) {
      debugPrint("API Key not found in database");
      return false;
    }

    if (fcmToken == null) {
      debugPrint("FCM Token not available");
      return false;
    }

    try {
      final response = await _dio.post(
        "/schedule",
        data: {
          "fcm_token": fcmToken,
          "title": title,
          "body": body,
          "scheduled_time": scheduledTime.toUtc().toIso8601String(),
          "note_id": noteId,
        },
        options: Options(
          headers: {"X-API-Key": apiKey},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint("Notification scheduled: $scheduledTime");
        return true;
      }
      return false;
    } on DioException catch (e) {
      debugPrint("Request error: ${e.message}");
      return false;
    }
  }

  static Future<void> cancelNotification(int notificationId) async {
    try {
      final db = Get.find<AppDatabase>();
      final apiKey = await db.getApiKey();

      await _dio.delete(
        "/schedule/$notificationId",
        options: Options(headers: {"X-API-Key": apiKey}),
      );
      debugPrint("Notification cancelled: $notificationId");
    } on DioException catch (e) {
      debugPrint("Cancel error: ${e.message}");
    }
  }
}
