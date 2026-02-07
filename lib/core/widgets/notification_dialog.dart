import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/note/controller/note_controller.dart';

class NotificationDialog extends StatelessWidget {
  final double width;
  final NoteController noteController;
  final String title;
  final String text;
  const NotificationDialog({
    super.key,
    required this.width,
    required this.noteController,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _showReminderDialog(context),
      child: Container(
        padding: EdgeInsets.all(width * 0.025),
        decoration: BoxDecoration(
          color: colorScheme.secondary.withAlpha(15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.notifications_active_outlined,
          color: colorScheme.secondary,
          size: width * 0.055,
        ),
      ),
    );
  }

  void _showReminderDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: colorScheme.surface,
          title: TextWidget(
            width: width,
            text: "set_reminder".tr(),
            fontSize: width * 0.05,
            fontWeight: FontWeight.w700,
            textColor: colorScheme.inversePrimary,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
//===========================================================================
//=============================== Date Picker ===============================
//===========================================================================
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    noteController.setNotificationDate(picked);
                  }
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    height: width * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withAlpha(15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.secondary.withAlpha(40),
                        width: 1.5,
                      ),
                    ),
                    child: TextWidget(
                      width: width,
                      text: "${noteController.notificationDate}",
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                      textColor: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * 0.02),
//===========================================================================
//=============================== Time Picker ===============================
//===========================================================================
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    noteController.setNotificationTime(picked);
                  }
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    height: width * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withAlpha(15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.secondary.withAlpha(40),
                        width: 1.5,
                      ),
                    ),
                    child: TextWidget(
                      width: width,
                      text: "${noteController.notificationTime}",
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                      textColor: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(
                width: width,
                text: "close".tr(),
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
                textColor: colorScheme.inversePrimary.withAlpha(150),
              ),
            ),
            TextButton(
              onPressed: () {
                final selectedDate = noteController.notificationDate.value;
                final selectedTime = noteController.notificationTime.value;

                DateTime? scheduledDateTime;
                if (selectedDate != "Date" && selectedTime != "Time") {
                  final dateParts =
                      selectedDate.split('-').map(int.parse).toList();
                  final timeParts =
                      selectedTime.split(':').map(int.parse).toList();
                  scheduledDateTime = DateTime(
                    dateParts[0],
                    dateParts[1],
                    dateParts[2],
                    timeParts[0],
                    timeParts[1],
                  );
                }

                if (scheduledDateTime != null &&
                    scheduledDateTime.isAfter(
                      DateTime.now(),
                    )) {
                  noteController.scheduleNotification(
                    title: title,
                    text: text,
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "error_time".tr(),
                      ),
                    ),
                  );
                }
              },
              child: TextWidget(
                width: width,
                text: "ok".tr(),
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                textColor: colorScheme.secondary,
              ),
            ),
          ],
        );
      },
    );
  }
}
