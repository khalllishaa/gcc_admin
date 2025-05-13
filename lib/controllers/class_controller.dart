import 'package:flutter/material.dart';
import 'package:gcc_admin/api_models/class_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/api_service.dart';

class ClassController extends GetxController {
  var classList = <ClassModel>[].obs;
  var studentsList = <User>[].obs;
  var isLoading = false.obs;
  var selectedClassName = ''.obs;
  var classNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getClasses();
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
    if (selectedClassName.value.isEmpty) {
      throw Exception('Tidak ada kelas yang dipilih.');
    }

    final selectedClass = classList.firstWhere((k) => k.name == selectedClassName.value);
    final classId = selectedClass.id;

    // Ambil token yang telah disimpan
    final box = GetStorage();
    String token = box.read('token') ?? '';  // Ambil token dari GetStorage

    if (token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }

    await ApiService.addStudent(name: name, classId: classId, token: token);
    await getStudents(classId); // Refresh daftar siswa
  }

}
