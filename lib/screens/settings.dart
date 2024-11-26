import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/widgets/text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GetXController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          width: width,
          text: "Setting",
          // text: LocaleKeys.setting.tr(),
          fontSize: width * 0.08,
          fontWeight: FontWeight.bold,
          textColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      width: width,
                      text: "Dark Theme",
                      fontSize: width * 0.06,
                      textColor: Theme.of(context).colorScheme.secondary,
                    ),
                    Obx(
                      () => Switch(
                        value: themeController.isLight.value,
                        onChanged: (bool value) {
                          themeController.changeTheme();
                        },
                        activeColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              // // Language Selection
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: width * 0.02),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       TextWidget(
              //         width: width,
              //         text: "Language",
              //         fontSize: width * 0.06,
              //         textColor: Theme.of(context).colorScheme.secondary,
              //       ),
              //       DropdownButton<String>(
              //         dropdownColor: Theme.of(context).colorScheme.secondary,
              //         elevation: 0,
              //         icon: Icon(
              //           Icons.language,
              //           color: Theme.of(context).colorScheme.secondary,
              //         ),
              //         items: <String>['English', 'Uzbek', 'Russian']
              //             .map((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: TextWidget(
              //               width: width,
              //               text: value,
              //               fontSize: width * 0.05,
              //             ),
              //           );
              //         }).toList(),
              //         onChanged: (String? newValue) {
              //           // themeController.changeLanguage(newValue!);
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              // const Divider(
              //   thickness: 2,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: width * 0.02),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       TextWidget(
              //         width: width,
              //         text: "Enable Notifications",
              //         fontSize: width * 0.06,
              //         textColor: Theme.of(context).colorScheme.secondary,
              //       ),
                    // Obx(
                    //   () => Switch(
                    //     // value: themeController.notificationsEnabled.value,
                    //     value: true,
                    //     onChanged: (bool value) {
                    //       // themeController.toggleNotifications(value);
                    //     },
                    //   ),
                    // ),
              //     ],
              //   ),
              // ),
              // const Divider(
              //   thickness: 2,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
