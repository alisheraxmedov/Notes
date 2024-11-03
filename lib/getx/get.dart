import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class GetXController extends GetxController {
//==================================================================
//========================= CHANGE THEME ===========================
//==================================================================

  var isLight = false.obs;

  void changeTheme() {
    isLight.value = !isLight.value;
  }

//==================================================================
//========================= DATE AND TIME ==========================
//==================================================================
  var date = "".obs;
  var month = "".obs;
  RxInt noteLenth = 0.obs;

  void initialDateTime() {
    DateTime dateTime = DateTime.now();

    date.value = dateTime.day.toString();
    month.value = dateTime.month.toString();
    switch (month.value) {
      case "1":
        month.value = "January";
        break;
      case "2":
        month.value = "Februaury";
        break;
      case "3":
        month.value = "March";
        break;
      case "4":
        month.value = "April";
        break;
      case "5":
        month.value = "May";
        break;
      case "6":
        month.value = "June";
        break;
      case "7":
        month.value = "July";
        break;
      case "8":
        month.value = "August";
        break;
      case "9":
        month.value = "September";
        break;
      case "10":
        month.value = "October";
        break;
      case "11":
        month.value = "November";
        break;
      case "12":
        month.value = "December";
        break;
      default:
        "Date";
    }
  }

  void noteLengthFunction(String text) {
    noteLenth.value = text.length;
  }

//===============================================================
//========================= INIT DATE  ==========================
//===============================================================
  RxString notificationDate = "Date".obs;
  void initNotificationDate(
    DateTime date,
  ) {
    notificationDate.value = "${date.year}-${date.month}-${date.day}";
  }

//===============================================================
//========================= INIT TIME  ==========================
//===============================================================
  RxString notificationTime = "Time".obs;
  void initNotificationTime(
    TimeOfDay time,
  ) {
    notificationTime.value = "${time.hour}:${time.minute}";
  }

//===============================================================
//========================= SAVE NOTES ==========================
//===============================================================
  final box = GetStorage();

  void saveNoteData(String title, String content, String date, String time) {
    final Map<String, String> noteData = {
      'title': title,
      'content': content,
      'date': date,
      'time': time,
    };
    box.write('noteData', noteData);
  }

  Map<String, String>? getNoteData() {
    return box.read('noteData');
  }

//=====================================================================
//========================= SET NOTIFICATION ==========================
//=====================================================================
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Initialize time zone data
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation('America/Detroit'),
    ); // Change to your preferred timezone
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledDate) async {
    // Convert DateTime to TZDateTime
    final tz.TZDateTime scheduledDateTime =
        tz.TZDateTime.from(scheduledDate, tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduledDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id', 
          'your_channel_name',
          channelDescription: 'your_channel_description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
