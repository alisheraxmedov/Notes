import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      print('Error navigating to home: $e');
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
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.note,
              size: width * 0.3, 
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            SizedBox(height: height * 0.05), 
            Text(
              "Notes App",
              style: TextStyle(
                fontSize: width * 0.08, 
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: height * 0.02), // Adjust space based on height
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onSecondary, // Spinner color from theme
            ),
          ],
        ),
      ),
    );
  }
}
