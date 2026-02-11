import 'package:get/get.dart';

/// Controller for the main bottom navigation bar.
/// Manages the active tab index and provides page switching logic.
class MainController extends GetxController {
  final RxInt activeIndex = 0.obs;

  void changeTab(int index) {
    activeIndex.value = index;
  }
}
