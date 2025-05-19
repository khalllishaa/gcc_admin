import 'package:flutter/material.dart';
import 'package:gcc_admin/api_models/class_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api_models/schedule_models.dart';
import '../components/AppStyles.dart';
import '../services/api_service.dart';

class ClassController extends GetxController {
  var classList = <ClassModel>[].obs;
  // var scheduleList = <ScheduleModels>[].obs;
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
    getClasses();
    // getSchedules();
    ever(selectedClassId, (_) {
      fetchScheduleByClassId(selectedClassId.value);
    });
  }

  Future<void> getClasses() async {
    isLoading.value = true;
    try {
      final result = await ApiService.fetchClasses();
      classList.value = result;
    } catch (e) {
      print('Error fetching classes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getStudents(int classId) async {
    isLoading.value = true;
    try {
      final classes = await ApiService.fetchClasses();
      final selectedClass = classes.firstWhere((kelas) => kelas.id == classId);
      selectedClassName.value = selectedClass.name;
      final students = selectedClass.users.where((user) => user.role == 'student').toList();
      studentsList.value = students;
    } catch (e) {
      print('Error fetching students: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSchedule(int classId) async {
    isLoading.value = true;
    try {
      final allSchedules = await ApiService.fetchSchedules();
      final classSchedules = allSchedules
          .where((schedule) => schedule.classId == classId)
          .toList();
      scheduleList.value = classSchedules;
    } catch (e) {
      print('Error fetching schedules: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> addClass() async {
    isLoading.value = true;
    try {
      String className = classNameController.text;

      if (className.isNotEmpty) {
        await ApiService.addClass(className);
        await getClasses();
        Get.back();
      } else {
        print('Nama kelas tidak boleh kosong');
      }
    } catch (e) {
      print('Error adding class: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStudentName(int id, String newName) async {
    await ApiService.updateStudent(id: id, name: newName);

    int index = studentsList.indexWhere((student) => student.id == id);
    if (index != -1) {
      studentsList[index] = studentsList[index].copyWith(name: newName);
      studentsList.refresh();
    }
  }

  Future<void> deleteStudent(int studentId) async {
    isLoading.value = true;
    try {
      await ApiService.deleteStudent(studentId);
      studentsList.removeWhere((student) => student.id == studentId);
    } catch (e) {
      print('Error deleting student: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteClass(int classId) async {
    isLoading.value = true;
    try {
      await ApiService.deleteClass(classId);
      await getClasses();
    } catch (e) {
      print('Error deleting class: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addStudent(String name) async {
    isLoading.value = true;
    try {
      final box = GetStorage();
      final token = box.read('token');
      if (token == null) {
        throw Exception('Token not found. User might not be logged in.');
      }

      final selectedClass = classList.firstWhere(
            (cls) => cls.name == selectedClassName.value,
        orElse: () => throw Exception('Selected class not found'),
      );

      await ApiService.addStudent(
        name: name,
        classId: selectedClass.id,
        token: token,
      );

      await getStudents(selectedClass.id);
    } catch (e) {
      print('Error adding student: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSchedules() async {
    isLoading.value = true;
    try {
      final result = await ApiService.fetchSchedules();
      print('Schedules fetched: $result');
      scheduleList.value = result;
    } catch (e) {
      print('Error fetching schedules: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchSchedulesByClass(int classId) async {
  //   try {
  //     isLoading.value = true;
  //     final allSchedules = await ApiService.fetchSchedules();
  //     scheduleList.value = allSchedules.where((s) => s.classId == classId).toList();
  //     scheduleList.assignAll(allSchedules);
  //   } catch (e) {
  //     print('Error fetching schedule: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void fetchScheduleByClassId(int classId) async {
    print('Fetching schedule for class ID: $classId');
    isLoading.value = true;
    try {
      final schedules = await ApiService.fetchSchedulesByClassId(classId);
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
      final result = await ApiService.fetchSchedulesByClassId(classId);
      schedules.value = result;
    } catch (e) {
      print('Error loading schedules: $e');
      schedules.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  // Future<bool> createSchedule(ScheduleModels schedule) async {
  //   isLoading.value = true;
  //   final result = await ApiService.createSchedule(schedule);
  //   isLoading.value = false;
  //
  //   if (result != null) {
  //     scheduleList.add(result);
  //     return true;
  //   }
  //   return false;
  // }

  Future<void> addSchedule({
    required String day,
    required String time,
    required String teacher,
    required String subject,
  }) async {
    try {
      await ApiService.createSchedule(
        day: day,
        time: time,
        teacher: teacher,
        subject: subject,
        classId: selectedClassId.value,
      );
      fetchScheduleByClassId(selectedClassId.value);
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
        'Gagal menambahkan user.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );    }
  }

}
