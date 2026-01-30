import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/settings/controller/settings_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          width: width,
          text: "settings".tr(),
          fontSize: width * 0.08,
          fontWeight: FontWeight.bold,
          textColor: Theme.of(context).colorScheme.onPrimary,
        ),
        centerTitle: true,
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
                      text: "light_theme".tr(),
                      fontSize: width * 0.06,
                      textColor: Theme.of(context).colorScheme.secondary,
                    ),
                    Obx(
                      () => Switch(
                        value: settingsController.isLight.value,
                        onChanged: (bool value) {
                          settingsController.changeTheme(value);
                        },
                        activeThumbColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              // Language Selection
              Padding(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      width: width,
                      text: "language".tr(),
                      fontSize: width * 0.06,
                      textColor: Theme.of(context).colorScheme.secondary,
                    ),
                    DropdownButton<Locale>(
                      dropdownColor: Theme.of(context).colorScheme.secondary,
                      elevation: 0,
                      value: context.locale,
                      icon: Icon(
                        Icons.language,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      items: context.supportedLocales.map((Locale locale) {
                        String name = "";
                        if (locale.languageCode == 'en') name = "English";
                        if (locale.languageCode == 'ru') name = "Русский";
                        if (locale.languageCode == 'uz') name = "O'zbek";
                        return DropdownMenuItem<Locale>(
                          value: locale,
                          child: TextWidget(
                            width: width,
                            text: name,
                            fontSize: width * 0.05,
                          ),
                        );
                      }).toList(),
                      onChanged: (Locale? newLocale) {
                        if (newLocale != null) {
                          context.setLocale(newLocale);
                          Get.updateLocale(newLocale);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
