import 'package:gcc_admin/controllers/class_controller.dart';
import 'package:gcc_admin/controllers/splashscreen_controller.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:gcc_admin/controllers/profile_controller.dart';
import 'package:get/get.dart';

class MainMenuBinding extends Bindings{
  @override
  void dependencies() {
    if (!Get.isRegistered<MainMenuController>()) {
      Get.lazyPut(() => MainMenuController());
    }

    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut(() => ProfileController());
    }

    if (!Get.isRegistered<ClassController>()) {
      Get.lazyPut(() => ClassController());
    }
    // if (!Get.isRegistered<HomeController>()) {
    //   Get.lazyPut(() => HomeController());
    // }
  }
}