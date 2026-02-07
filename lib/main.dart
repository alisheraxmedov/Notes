import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes/data/local/database.dart';
import 'package:notes/data/services/notification_service.dart';
import 'package:notes/features/splash/view/splash_view.dart';
import 'package:notes/core/theme/theme.dart';
import 'package:notes/features/settings/controller/settings_controller.dart';
import 'package:notes/features/settings/controller/auth_controller.dart';
import 'package:notes/features/note/controller/note_controller.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:notes/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  await NotificationService.init();
  await EasyLocalization.ensureInitialized();

  final db = AppDatabase();
  Get.put(db);

  Get.put(SettingsController());
  Get.put(AuthController());
  Get.put(NoteController());

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('uz'),
      ],
      // assetLoader: const CodegenLoader(),
      path: 'assets/translations',
      startLocale: const Locale('uz'),
      saveLocale: true,
      child: const MyApp(),
    ),
    // const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    // Ensure initial theme mode is set correctly
    return Obx(
      () => GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,

        // Define both themes
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,

        // Use themeMode to switch
        themeMode:
            settingsController.isLight.value ? ThemeMode.light : ThemeMode.dark,

        home: const SplashScreen(),
      ),
    );
  }
}
