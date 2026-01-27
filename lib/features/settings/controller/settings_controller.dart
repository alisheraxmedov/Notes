import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _box = GetStorage();
  var isLight = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLight.value = _box.read('isLight') ?? false;
  }

  void changeTheme(bool value) {
    isLight.value = value;
    _box.write('isLight', isLight.value);
  }
}
