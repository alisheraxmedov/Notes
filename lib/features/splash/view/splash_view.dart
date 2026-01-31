import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:lottie/lottie.dart';
import 'package:notes/core/const/colors.dart';
import 'package:notes/features/home/view/home_view.dart';
import 'package:notes/features/note/controller/note_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final NoteController noteController = Get.find();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() async {
    // Navigate after animation completes
    noteController.fetchNotes();
    Get.off(() => const HomeScreen());
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
              child: Lottie.asset(
                "assets/lottie/notes.json",
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward().whenComplete(() => _navigateToHome());
                },
              ),
            ),
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "reminder".tr(),
                  style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: ColorClass.red,
                  ),
                ),
                Text(
                  "app_title".tr(),
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
