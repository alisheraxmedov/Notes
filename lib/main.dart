import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/screens/splash.dart';
import 'package:notes/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetXController getxcontroller = Get.put(
    GetXController(),
  );
  await getxcontroller.initNotifications();
  runApp(
    const MyApp(),
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
