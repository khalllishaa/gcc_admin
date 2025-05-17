import 'package:flutter/material.dart';
import 'package:gcc_admin/data/models/class_model.dart';
import 'package:get/get.dart';

import '../data/services/class_service.dart';
import '../data/services/student_service.dart';
import '../data/models/class_model.dart';
import '../data/models/user_model.dart';

class ClassController extends GetxController {
  var classList = <ClassModel>[].obs;
  var studentsList = <User>[].obs;
  var isLoading = false.obs;
  var classNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getClasses();
  }

  Future<void> getClasses() async {
    isLoading.value = true;
    try {
      final result = await ClassService.fetchClasses();
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
      final students = await ClassService.fetchStudents(classId);

      studentsList.value = students;
    } catch (e) {
      print('Error fetching students: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addStudent({
    required String name,
    required int classId,
  }) async {
    isLoading.value = true;
    try {
      await StudentService.addStudent(
        name: name,
        classId: classId,
      );
      await getStudents(classId);
    } catch (e) {
      print('Error adding student: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addClass() async {
    isLoading.value = true;
    try {
      String className = classNameController.text;

      if (className.isNotEmpty) {
        await ClassService.addClass(className);
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
}
