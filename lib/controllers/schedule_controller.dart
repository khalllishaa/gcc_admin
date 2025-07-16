import 'package:flutter/material.dart';
import 'package:gcc_admin/controllers/subject_controller.dart';
import 'package:gcc_admin/data/services/schedule_service.dart';
import 'package:get/get.dart';
import '../components/AppStyles.dart';
import '../data/models/class_model.dart';
import '../data/models/schedule_model.dart';
import '../data/models/teacher_model.dart';
import '../data/services/teacher_service.dart';

class ScheduleController extends GetxController {
  var classList = <ClassModel>[].obs;
  RxList<ScheduleModels> scheduleList = <ScheduleModels>[].obs;
  var studentsList = <User>[].obs;
  var isLoading = false.obs;
  var selectedClassName = ''.obs;
  var classNameController = TextEditingController();
  var schedules = <ScheduleModels>[].obs;
  var selectedClassId = 0.obs;
  RxString selectedDay = ''.obs;
  RxString selectedTime = ''.obs;
  RxList<TeacherModel> teachers = <TeacherModel>[].obs;
  RxString selectedTeacher = ''.obs;
  final RxString selectedSubject = ''.obs;
  RxInt selectedTeacherId = 0.obs;
  RxInt selectedSubjectId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(selectedClassId, (_) {
      fetchScheduleByClassId(selectedClassId.value);
    });
    fetchActiveTeachers();
  }

  Future<void> fetchActiveTeachers() async {
    try {
      final response = await TeacherService().fetchTeachers();
      teachers.value = response.where((t) => t.status == 'active').toList();
    } catch (e) {
      print('Error fetch teachers: $e');
    }
  }

  void fetchScheduleByClassId(int classId) async {
    print('Fetching schedule for class ID: $classId');
    isLoading.value = true;
    try {
      final schedules = await ScheduleService.fetchSchedulesByClassId(classId);
      scheduleList.value = schedules;
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadSchedules(int classId) async {
    isLoading.value = true;
    try {
      final result = await ScheduleService.fetchSchedulesByClassId(classId);
      schedules.value = result;
    } catch (e) {
      schedules.value = [];
      print('Error loading schedule: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addSchedule({
    required String day,
    required String time,
    required int teacherId,
    required int subjectId,
  }) async {
    try {
      final parts = time.split(' - ');
      final startTime = parts[0].trim();
      final endTime = parts[1].trim();

      final teacherName = teachers.firstWhere((e) => e.id == teacherId).name;
      final subjectName = Get.find<SubjectController>().subjects.firstWhere((e) => e.id == subjectId).name;

      await ScheduleService.createSchedule(
        day: day,
        startTime: startTime,
        endTime: endTime,
        teacherId: teacherId,
        subjectId: subjectId,
        classId: selectedClassId.value,
        teacherName: teacherName,
        subjectName: subjectName,
      );


      fetchScheduleByClassId(selectedClassId.value);
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
      await ScheduleService.deleteSchedule(id);
      scheduleList.removeWhere((item) => item.id == id);
    } catch (e) {
      print('Error deleting schedule: $e');
    } finally {
      isLoading(false);
    }
  }

  void pickTimeRange(BuildContext context) async {
    TimeOfDay? start = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (start != null) {
      TimeOfDay? end = await showTimePicker(context: context, initialTime: start);
      if (end != null) {
        selectedTime.value = '${start.format(context)} - ${end.format(context)}';
      }
    }
  }
}