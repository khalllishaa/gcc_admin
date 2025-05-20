import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/AppStyles.dart';
import '../data/models/teacher_model.dart';
import '../data/services/teacher_service.dart';

class ListTeacherController extends GetxController {
  final teachers = <TeacherModel>[].obs;
  final isLoading = false.obs;

  final TeacherService _teacherService = TeacherService();

  @override
  void onInit() {
    super.onInit();
    fetchTeachers();
  }

  Future<void> fetchTeachers() async {
    try {
      isLoading.value = true;
      final result = await _teacherService.fetchTeachers();
      teachers.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTeacher(String name, int classId) async {
    try {
      final newTeacher = await _teacherService.addTeacher(name, classId);
      teachers.add(newTeacher);

    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  Future<void> deleteTeacher(int id) async {
    try {
      await _teacherService.deleteTeacher(id);
      teachers.removeWhere((t) => t.id == id);
      Get.snackbar(
        'Succes',
        'Guru berhasil dihapus.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateTeacher(int id, String newName) async {
    try {
      isLoading.value = true;
      final updatedTeacher = await _teacherService.updateTeacherName(id, newName);

      final index = teachers.indexWhere((t) => t.id == id);
      if (index != -1) {
        teachers[index] = updatedTeacher;
        teachers.refresh();
      }

      isLoading.value = false;
      Get.back();
      Get.snackbar(
        'Sukses',
        'Nama guru berhasil diperbarui.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
