import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/widgets/text.dart';

class NotificationDialog extends StatelessWidget {
  final double width;
  final GetXController themeController;
  const NotificationDialog({
    super.key,
    required this.width,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.04),
      child: Container(
        height: width * 0.12,
        width: width * 0.12,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: IconButton(
          icon: const Icon(
            Icons.notifications_active_outlined,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: TextWidget(
                    width: width,
                    text: "Set notification",
                    fontSize: width * 0.05,
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
                            themeController.initNotificationDate(picked);
                          }
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            height: width * 0.1,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            child: TextWidget(
                              width: width,
                              text: "${themeController.notificationDate}",
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ),
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
                            themeController.initNotificationTime(picked);
                          }
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            height: width * 0.1,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            child: TextWidget(
                              width: width,
                              text: "${themeController.notificationTime}",
                              fontSize: width * 0.04,
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
                        text: "Close",
                        fontSize: width * 0.04,
                        
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: TextWidget(
                        width: width,
                        text: "OK",
                        fontSize: width * 0.04,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
