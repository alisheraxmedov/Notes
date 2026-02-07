import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;
import 'package:notes/core/const/colors.dart';
import 'package:notes/data/local/database.dart';

class NoteController extends GetxController {
  final AppDatabase _db = Get.find<AppDatabase>();

  RxList<Note> allNotesList = <Note>[].obs;
  RxBool isLoading = false.obs;

  // Date and Time for Note Creation
  var selectedDate = "".obs;
  var selectedMonth = "".obs;
  RxInt noteLength = 0.obs;

  // Notification Selection
  RxString notificationDate = "Date".obs;
  RxString notificationTime = "Time".obs;

  // Search and Filter
  RxList<Note> filteredNotesList = <Note>[].obs;
  RxString searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    initialDateTime();
    fetchNotes();

    // Debounce search
    debounce(searchQuery, (_) => filterNotes(),
        time: const Duration(milliseconds: 300));

    // Update filtered list
    ever(allNotesList, (_) => filterNotes());
  }

  // ==================== DATA FETCHING ====================

  Future<void> fetchNotes() async {
    try {
      isLoading.value = true;
      // Drift: select(notes).get() returns Future<List<Note>>
      // final notes = await _db.select(_db.notes).get();

      // Sort by creation date descending (in memory for now, or use orderBy in drift)
      // notes.sort((a, b) => b.created.compareTo(a.created));
      // Better to use Drift orderBy
      final sortedNotes = await (_db.select(_db.notes)
            ..orderBy([
              (t) => drift.OrderingTerm(
                  expression: t.created, mode: drift.OrderingMode.desc)
            ]))
          .get();

      allNotesList.assignAll(sortedNotes);
    } catch (e) {
      if (Get.context != null && Get.isOverlaysClosed) {
        Get.snackbar(
          "Error",
          "Failed to load notes: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorClass.red.withValues(alpha: 0.8),
          colorText: ColorClass.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ==================== SEARCH & FILTER ====================

  void filterNotes() {
    String query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredNotesList.assignAll(allNotesList);
    } else {
      filteredNotesList.assignAll(
        allNotesList.where((note) {
          return note.title.toLowerCase().contains(query);
        }),
      );
    }
  }

  // ==================== CRUD OPERATIONS ====================

  Future<void> addNotes({
    required String title,
    required String content,
    required String date,
    required String time,
    String? nDate,
    String? nTime,
    String? today,
  }) async {
    try {
      isLoading.value = true;

      final companion = NotesCompanion(
        title: drift.Value(title),
        content: drift.Value(content),
        date: drift.Value(date),
        time: drift.Value(time),
        nDate: drift.Value(nDate),
        nTime: drift.Value(nTime),
        today: drift.Value(today),
      );

      await _db.into(_db.notes).insert(companion);
      await fetchNotes(); // Refresh list
    } catch (e) {
      if (Get.context != null && Get.isOverlaysClosed) {
        Get.snackbar(
          "Error",
          "Failed to save note: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorClass.red.withValues(alpha: 0.8),
          colorText: ColorClass.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNotes({
    required int id,
    required String title,
    required String content,
    required String date,
    required String time,
    required String nDate,
    required String nTime,
    required String today,
  }) async {
    try {
      isLoading.value = true;

      final companion = NotesCompanion(
        id: drift.Value(id),
        title: drift.Value(title),
        content: drift.Value(content),
        date: drift.Value(date),
        time: drift.Value(time),
        nDate: drift.Value(nDate),
        nTime: drift.Value(nTime),
        today: drift.Value(today),
        updated: drift.Value(DateTime.now()),
      );

      await (_db.update(_db.notes)..where((t) => t.id.equals(id)))
          .write(companion);
      await fetchNotes();

      // Get.back(); // Close Edit Screen - Handled in UI
      // Get.back(); // Check if double back is needed
    } catch (e) {
      if (Get.context != null && Get.isOverlaysClosed) {
        Get.snackbar(
          "Error",
          "Failed to update note: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorClass.red.withValues(alpha: 0.8),
          colorText: ColorClass.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNoteReminder(int id, String nDate, String nTime) async {
    try {
      final companion = NotesCompanion(
        nDate: drift.Value(nDate),
        nTime: drift.Value(nTime),
        updated: drift.Value(DateTime.now()),
      );

      await (_db.update(_db.notes)..where((t) => t.id.equals(id)))
          .write(companion);
      await fetchNotes();
    } catch (e) {
      debugPrint("Error updating reminder: $e");
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await (_db.delete(_db.notes)..where((t) => t.id.equals(id))).go();

      // Update local list
      allNotesList.removeWhere((note) => note.id == id);

      if (Get.context != null && Get.isOverlaysClosed) {
        Get.snackbar("Deleted", "Note deleted successfully",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      fetchNotes();
      if (Get.context != null && Get.isOverlaysClosed) {
        Get.snackbar(
          "Error",
          "Failed to delete note: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorClass.red.withValues(alpha: 0.8),
          colorText: ColorClass.white,
        );
      }
    }
  }

  // Clean up DB when controller is disposed (rarely called for singleton-like usage)
  @override
  void onClose() {
    _db.close();
    super.onClose();
  }

  // ==================== HELPER FUNCTIONS ====================

  void initialDateTime() {
    DateTime dateTime = DateTime.now();
    selectedDate.value = dateTime.day.toString();

    // Reset notification values for new notes
    notificationDate.value = "Date";
    notificationTime.value = "Time";

    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    selectedMonth.value = months[dateTime.month - 1];
  }

  void updateNoteLength(String text) {
    noteLength.value = text.length;
  }

  void setNotificationDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    notificationDate.value = "${date.year}-$month-$day";
  }

  void setNotificationTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    notificationTime.value = "$hour:$minute";
  }

  Future<void> scheduleNotification({
    required String title,
    required String text,
    int? noteId,
  }) async {
    if (notificationDate.value != "Date" && notificationTime.value != "Time") {
      try {
        DateTime now = DateTime.now();
        List<String> d = notificationDate.value.split('-');
        List<String> t = notificationTime.value.split(':');

        DateTime scheduledDate = DateTime(int.parse(d[0]), int.parse(d[1]),
            int.parse(d[2]), int.parse(t[0]), int.parse(t[1]));

        if (scheduledDate.isAfter(now)) {
          // Import cloud_firestore and save reminder to Firestore
          // This will be picked up by your server to send FCM notification
          debugPrint('Reminder scheduled for: $scheduledDate');
          debugPrint('Title: $title, Text: $text');

          // await FirebaseFirestore.instance.collection('reminders').add({
          //   'fcmToken': NotificationService.fcmToken,
          //   'title': title,
          //   'body': text,
          //   'scheduledTime': scheduledDate.toIso8601String(),
          //   'noteId': noteId,
          //   'sent': false,
          //   'createdAt': FieldValue.serverTimestamp(),
          // });
        }
      } catch (e) {
        debugPrint("Error scheduling notification: $e");
      }
    }
  }
}
