import 'package:flutter/material.dart';
import 'package:gcc_admin/api_models/class_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api_models/schedule_models.dart';
import '../services/api_service.dart';

class ClassController extends GetxController {
  var classList = <ClassModel>[].obs;
  // var scheduleList = <ScheduleModels>[].obs;
  RxList<ScheduleModels> scheduleList = <ScheduleModels>[].obs;
  var studentsList = <User>[].obs;
  var isLoading = false.obs;
  var selectedClassName = ''.obs;
  var classNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getClasses();
    getSchedules();
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

  Future<void> fetchSchedulesByClass(int classId) async {
    try {
      isLoading.value = true;
      final allSchedules = await ApiService.fetchSchedules();
      scheduleList.value = allSchedules.where((s) => s.classId == classId).toList();
      scheduleList.assignAll(allSchedules);
    } catch (e) {
      print('Error fetching schedule: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
