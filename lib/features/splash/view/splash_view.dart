import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/core/const/colors.dart';
import 'package:notes/features/home/view/home_view.dart';
import 'package:notes/features/note/controller/note_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final NoteController noteController = Get.find();

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    try {
      await Future.delayed(const Duration(seconds: 3), () {
        noteController.readNotes();
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
            SizedBox(
              height: width * 0.7,
              width: width * 0.7,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/icons/1024.png"),
              //   ),
              // ),
              child: Lottie.asset(
                "assets/lottie/notes.json",
              ),
            ),
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Reminder",
                  style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: ColorClass.red,
                  ),
                ),
                Text(
                  " Notes",
                  style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: ColorClass.deepGreen,
                  ),
                ),
              ],
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
