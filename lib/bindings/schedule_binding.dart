import 'package:gcc_admin/controllers/schedule_controller.dart';
import 'package:get/get.dart';

class ScheduleBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController());
  }

}