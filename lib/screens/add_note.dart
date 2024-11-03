import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notes/functions/add_read_delete.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/widgets/notification_dialog.dart';
import 'package:notes/widgets/text.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  AddNoteScreenState createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final GetXController themeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          width: width,
          text: "Add Note",
          fontSize: width * 0.09,
        ),
//======================================================================
//========================= Set notification ===========================
//======================================================================
        actions: [
          NotificationDialog(
            width: width,
            themeController: themeController,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Enter a title for the note',
                  border: InputBorder.none,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: width * 0.01),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Row(
                  children: [
                    TextWidget(
                      width: width,
                      text: "${themeController.date}-${themeController.month}",
                      fontSize: width * 0.03,
                    ),
                    TextWidget(
                      width: width,
                      text: " | ",
                      fontSize: width * 0.03,
                    ),
                    Obx(
                      () => TextWidget(
                        width: width,
                        text: "${themeController.noteLenth} ta belgi",
                        fontSize: width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              TextField(
                controller: _contentController,
                onChanged: (value) {
                  themeController.noteLengthFunction(
                    value.toString(),
                  );
                },
                decoration: const InputDecoration(
                  labelText: 'Start writing...',
                  labelStyle: TextStyle(),
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
              SizedBox(
                height: width * 0.02,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  NotesAddReadDelete.addNotes(
                    title: _titleController.text,
                    content: _contentController.text,
                    date: themeController.notificationDate.value,
                    time: themeController.notificationTime.value,
                  );
                  Get.back();
                  // print(_titleController.text);
                  // print(_contentController.text);
                  // print(themeController.notificationDate.value);
                  // print(themeController.notificationTime.value);
                },
                child: Container(
                  height: width * 0.17,
                  width: width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(
                      width * 0.02,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: TextWidget(
                    width: width,
                    text: "Save",
                    fontSize: width * 0.09,
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



 // Future<void> _scheduleNotification() async {
  //   if (_selectedDate != null && _selectedTime != null) {
  //     final DateTime scheduledDateTime = DateTime(
  //       _selectedDate!.year,
  //       _selectedDate!.month,
  //       _selectedDate!.day,
  //       _selectedTime!.hour,
  //       _selectedTime!.minute,
  //     );

      // await flutterLocalNotificationsPlugin.zonedSchedule(
      //   0,
      //   _titleController.text,
      //   _contentController.text,
      //   scheduledDateTime,
      //   const NotificationDetails(
      //     android: AndroidNotificationDetails(
      //       'your_channel_id',
      //       'your_channel_name',
      //       channelDescription: 'your_channel_description',
      //     ),
      //   ),
      //   androidAllowWhileIdle: true,
      //   uiLocalNotificationDateInterpretation:
      //       UILocalNotificationDateInterpretation.absoluteTime,
      //   matchDateTimeComponents: DateTimeComponents.time,
      // );
  //   }
  // }

  // void _saveNote() {
  //   if (_titleController.text.isNotEmpty &&
  //       _contentController.text.isNotEmpty) {
  //     _scheduleNotification();
  //     Navigator.pop(context); // Go back to the previous page
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Title and content cannot be empty")),
  //     );
  //   }
  // }