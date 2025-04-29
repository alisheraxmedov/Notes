import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/generated/codegen_loader.g.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/notification/notification.dart';
import 'package:notes/screens/splash.dart';
import 'package:notes/theme/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService.init();
  await EasyLocalization.ensureInitialized();

  GetXController getxcontroller = Get.put(
    GetXController(),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', "US"),
        Locale('ru', "RU"),
        Locale('uz', "UZ"),
      ],
      assetLoader: const CodegenLoader(),
      path: 'assets/translations/',
      startLocale: const Locale('uz', "UZ"),
      // saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GetXController themeController = Get.find();
    return Obx(
      () {
        return GetMaterialApp(
          // localizationsDelegates: context.localizationDelegates,
          // supportedLocales: context.supportedLocales,
          // locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: themeController.isLight.value
              ? MyAppTheme.lightTheme
              : MyAppTheme.darkTheme,
          home: const SplashScreen(),
          // home: const GetStorageScreen(),
        );
      },
    );
  }
}
