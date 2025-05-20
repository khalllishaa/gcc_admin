import 'package:gcc_admin/controllers/class_controller.dart';
import 'package:get/get.dart';

class ClassBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ClassController>(() => ClassController());
  }

}