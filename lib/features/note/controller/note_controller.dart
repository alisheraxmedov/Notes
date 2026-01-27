import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes/data/models/note_model.dart';
import 'package:notes/data/services/notification_service.dart';

class NoteController extends GetxController {
  final GetStorage box = GetStorage();
  RxList<NoteModel> allNotesList = <NoteModel>[].obs;

  // Date and Time for Note Creation
  var selectedDate = "".obs;
  var selectedMonth = "".obs;
  RxInt noteLength = 0.obs;

  // Notification Selection
  RxString notificationDate = "Date".obs;
  RxString notificationTime = "Time".obs;

  @override
  void onInit() {
    super.onInit();
    readNotes();
    initialDateTime();
  }

  void readNotes() {
    List<dynamic> notesList = box.read("notes") ?? [];
    allNotesList
        .assignAll(notesList.map((e) => NoteModel.fromJson(e)).toList());
  }

  void addNotes({
    required String title,
    required String content,
    required String date,
    required String time,
    String? nDate,
    String? nTime,
    String? today,
  }) {
    NoteModel note = NoteModel(
      title: title,
      content: content,
      date: date,
      time: time,
      nDate: nDate,
      nTime: nTime,
      today: today,
    );

    List<dynamic> notesList = box.read("notes") ?? [];
    notesList.add(note.toJson());
    box.write("notes", notesList);

    allNotesList.add(note);
  }

  void updateNotes({
    required String title,
    required String content,
    required String date,
    required String time,
    required String nDate,
    required String nTime,
    required String today,
    int? index,
  }) {
    NoteModel note = NoteModel(
      title: title,
      content: content,
      date: date,
      time: time,
      nDate: nDate,
      nTime: nTime,
      today: today,
    );

    List<dynamic> notesList = box.read("notes") ?? [];

    if (index != null) {
      notesList[index] = note.toJson();
    } else {
      notesList.add(note.toJson());
    }

    box.write("notes", notesList);
    readNotes(); // Refresh list
  }

  void deleteNoteByTitle(String title) {
    List<dynamic> notesList = box.read("notes") ?? [];
    notesList.removeWhere((note) => note["title"] == title);
    box.write("notes", notesList);
    readNotes();
  }

  void deleteNoteAt(int index) {
    List<dynamic> notesList = box.read("notes") ?? [];
    if (index >= 0 && index < notesList.length) {
      notesList.removeAt(index);
      box.write("notes", notesList);
      readNotes();
    }
  }

  void deleteAllNotes() {
    box.remove("notes");
    allNotesList.clear();
  }

  // Helper Functions
  void initialDateTime() {
    DateTime dateTime = DateTime.now();
    selectedDate.value = dateTime.day.toString();

    // Simple month mapping
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
    notificationDate.value = "${date.year}-${date.month}-${date.day}";
  }

  void setNotificationTime(TimeOfDay time) {
    notificationTime.value = "${time.hour}:${time.minute}";
  }

  Future<void> scheduleNotification({
    required String title,
    required String text,
  }) async {
    if (notificationDate.value != "Date" && notificationTime.value != "Time") {
      try {
        DateTime now = DateTime.now();
        List<String> d = notificationDate.value.split('-');
        List<String> t = notificationTime.value.split(':');

        DateTime scheduledDate = DateTime(int.parse(d[0]), int.parse(d[1]),
            int.parse(d[2]), int.parse(t[0]), int.parse(t[1]));

        if (scheduledDate.isAfter(now)) {
          int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
          await NotificationService.scheduleNotification(
            notificationId,
            title,
            text,
            scheduledDate,
          );
        }
      } catch (e) {
        debugPrint("Error scheduling notification: $e");
      }
    }
  }
}
