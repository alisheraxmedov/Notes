import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/timezone.dart' as tz;

class GetXController extends GetxController {
//==================================================================
//========================= CHANGE THEME ===========================
//==================================================================
  final _box = GetStorage();
  var isLight = false.obs;

  void onInitTheme() {
    super.onInit();
    isLight.value = _box.read('isLight') ?? false;
  }

  void changeTheme() {
    isLight.value = !isLight.value;
    _box.write('isLight', isLight.value);
  }

//==================================================================
//========================= DATE AND TIME ==========================
//==================================================================
  var selectedDate = "".obs;
  var selectedMonth = "".obs;
  RxInt noteLength = 0.obs;

  void initialDateTime() {
    DateTime dateTime = DateTime.now();

    selectedDate.value = dateTime.day.toString();
    selectedMonth.value = dateTime.month.toString();
    switch (selectedMonth.value) {
      case "1":
        selectedMonth.value = "January";
        break;
      case "2":
        selectedMonth.value = "February";
        break;
      case "3":
        selectedMonth.value = "March";
        break;
      case "4":
        selectedMonth.value = "April";
        break;
      case "5":
        selectedMonth.value = "May";
        break;
      case "6":
        selectedMonth.value = "June";
        break;
      case "7":
        selectedMonth.value = "July";
        break;
      case "8":
        selectedMonth.value = "August";
        break;
      case "9":
        selectedMonth.value = "September";
        break;
      case "10":
        selectedMonth.value = "October";
        break;
      case "11":
        selectedMonth.value = "November";
        break;
      case "12":
        selectedMonth.value = "December";
        break;
      default:
        "Date";
    }
  }

  void noteLengthFunction(String text) {
    noteLength.value = text.length;
  }

//===============================================================
//========================= INIT DATE  ==========================
//===============================================================
  RxString notificationDate = "Date".obs;
  void initNotificationDate(DateTime date) {
    notificationDate.value = "${date.year}-${date.month}-${date.day}";
  }

//===============================================================
//========================= INIT TIME  ==========================
//===============================================================
  RxString notificationTime = "Time".obs;
  void initNotificationTime(TimeOfDay time) {
    notificationTime.value = "${time.hour}:${time.minute}";
  }

//=====================================================================
//========================= SET NOTIFICATION ==========================
//=====================================================================
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification({
    required String title,
    required String text,
  }) async {
    if (notificationDate.value != "Date" && notificationTime.value != "Time") {
      DateTime now = DateTime.now();
      // Parse selected date and time for scheduling
      DateTime scheduledDate = DateTime(
        int.parse(notificationDate.value.split('-')[0]),
        int.parse(notificationDate.value.split('-')[1]),
        int.parse(notificationDate.value.split('-')[2]),
        int.parse(notificationTime.value.split(':')[0]),
        int.parse(notificationTime.value.split(':')[1]),
      );

      if (scheduledDate.isAfter(now)) {
        tz.TZDateTime tzScheduledDate =
            tz.TZDateTime.from(scheduledDate, tz.local);
        await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          title,
          text,
          tzScheduledDate,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'your_channel_id',
              'your_channel_name',
              channelDescription: 'your_channel_description',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dateAndTime,
        );
      }
    }
  }

//============================================================================
//========================= NOTES ADD, READ, DELETE ==========================
//============================================================================
  GetStorage box = GetStorage();

  RxList<Map<String, dynamic>> allNotesList = <Map<String, dynamic>>[].obs;

  void addNotes({
    required String title,
    required String content,
    required String date,
    required String time,
    required String rtime,
    required String rdate,
  }) {
    Map<String, dynamic> notesMap = {
      "title": title,
      "content": content,
      "date": date,
      "time": time,
    };
    List notesList = box.read("notes") ?? [];
    notesList.add(notesMap);
    box.write("notes", notesList);

    allNotesList.assignAll(List<Map<String, dynamic>>.from(notesList));
  }

//========================================================
//======================== UPDATE ========================
  void updateNotes({
    required String title,
    required String content,
    required String date,
    required String time,
    required String notificationDate,
    required String notificationTime,
    required String today,
    int? index,
  }) {
    Map<String, dynamic> notesMap = {
      "title": title,
      "content": content,
      "date": date,
      "time": time,
      "nDate": notificationDate,
      "nTime": notificationTime,
      "today": today,
    };

    List notesList = box.read("notes") ?? [];

    if (index != null) {
      notesList[index] = notesMap;
    } else {
      notesList.add(notesMap);
    }

    box.write("notes", notesList);
    allNotesList.assignAll(List<Map<String, dynamic>>.from(notesList));
  }

//======================================================
//====================== GET TIME ======================
  // final String timeformatted = '';
  // void getTimeFormatted(int index) {
  //   List notes = box.read("notes") ?? [];

  // }

//======================================================
//======================== READ ========================
  void readNotes() {
    List<dynamic> notesList = box.read("notes") ?? [];
    allNotesList.assignAll(List<Map<String, dynamic>>.from(notesList));
  }

//========================================================
//======================== DELETE ========================
  void deleteSelectedNotes({required String title}) {
    List notesList = box.read("notes") ?? [];
    notesList.removeWhere((note) => note["title"] == title);
    box.write("notes", notesList);

    allNotesList.assignAll(List<Map<String, dynamic>>.from(notesList));
  }

  void deleteAllNotes() {
    box.remove("notes");
    allNotesList.clear();
  }

  @override
  void onInit() {
    readNotes();
    super.onInit();
  }
}
