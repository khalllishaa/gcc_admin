import 'package:gcc_admin/controllers/splashscreen_controller.dart';
import 'package:get/get.dart';

class SplashscreenBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SplashscreenContoller>(() => SplashscreenContoller());
  }

}