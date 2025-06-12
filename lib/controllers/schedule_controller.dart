import 'package:flutter/material.dart';
import 'package:gcc_admin/data/services/schedule_service.dart';
import 'package:get/get.dart';

import '../components/AppStyles.dart';
import '../data/models/class_model.dart';
import '../data/models/schedule_model.dart';

class ScheduleController extends GetxController{
  var classList = <ClassModel>[].obs;
  RxList<ScheduleModels> scheduleList = <ScheduleModels>[].obs;
  var studentsList = <User>[].obs;
  var isLoading = false.obs;
  var selectedClassName = ''.obs;
  var classNameController = TextEditingController();
  var schedules = <ScheduleModels>[].obs;
  var selectedClassId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(selectedClassId, (_) {
      fetchScheduleByClassId(selectedClassId.value);
    });
  }

  void fetchScheduleByClassId(int classId) async {
    print('Fetching schedule for class ID: $classId');
    isLoading.value = true;
    try {
      final schedules = await ScheduleService.fetchSchedulesByClassId(classId);
      print('Fetched schedules: $schedules');
      scheduleList.value = schedules;
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
      print('Done loading');
    }
  }


  void loadSchedules(int classId) async {
    isLoading.value = true;
    try {
      final result = await ScheduleService.fetchSchedulesByClassId(classId);
      schedules.value = result;
    } catch (e) {
      print('Error loading schedules: $e');
      schedules.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addSchedule({
    required String day,
    required String time,
    required String teacher,
    required String subject,
  }) async {
    try {
      await ScheduleService.createSchedule(
        day: day,
        time: time,
        teacher: teacher,
        subject: subject,
        classId: selectedClassId.value,
      );
      fetchScheduleByClassId(selectedClassId.value);
      Get.back();
      Get.snackbar(
        'Sukses',
        'Schedule berhasil ditambahkan!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );
    } catch (e) {
      print('Error adding schedule: $e');

      Get.snackbar(
        'Error',
        'Gagal menambahkan schedule.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );
    }
  }

  Future<void> deleteSchedule(int id) async {
    try {
      isLoading(true);
      await ScheduleService.deleteSchedule(id.toString());
      scheduleList.removeWhere((element) => element.id == id);
      Get.snackbar(
        'Sukses',
        'Schedule berhasil dihapus!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus schedule.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );    } finally {
      isLoading(false);
    }
  }

}