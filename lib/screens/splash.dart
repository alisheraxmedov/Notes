import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/const/colors.dart';
import 'package:notes/getx/get.dart';
import 'package:notes/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GetXController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    try {
      await Future.delayed(const Duration(seconds: 3), () {
        themeController.readNotes();
        themeController.onInitTheme();
      });
      Get.off(() => const HomeScreen());
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: ColorClass.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: width*0.3,
              width: width*0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/1024.png"),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            Text(
              "Notes App",
              style: TextStyle(
                fontSize: width * 0.08,
                fontWeight: FontWeight.bold,
                color: ColorClass.black,
              ),
            ),
            // SizedBox(height: height * 0.02),
            // CircularProgressIndicator(
            //   color: Theme.of(context).colorScheme.onSecondary,
            // ),
          ],
        ),
      ),
    );
  }
}
