import 'package:flutter/material.dart';
import 'package:gcc_admin/data/models/class_model.dart';
import 'package:get/get.dart';
import '../components/AppStyles.dart';
import '../data/services/class_service.dart';

class ClassController extends GetxController {
  var classList = <ClassModel>[].obs;
  var studentsList = <User>[].obs;
  var isLoading = false.obs;
  var classNameController = TextEditingController();
  var selectedClassName = ''.obs;

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
      final classes = await ClassService.fetchClasses();
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
        await ClassService.addClass(className);
        await getClasses();
        Get.back();

        Get.snackbar(
          'Sukses',
          'Kelas berhasil ditambahkan!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppStyles.welcome,
          colorText: AppStyles.dark,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(16),
        );
      } else {
        Get.snackbar(
          'Peringatan',
          'Nama kelas tidak boleh kosong',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppStyles.error,
          colorText: AppStyles.light,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      print('Error adding class: $e');
      Get.snackbar(
        'Error',
        'Gagal menambahkan kelas.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> updateStudentName(int id, String newName) async {
    await ClassService.updateStudent(id: id, name: newName);

    int index = studentsList.indexWhere((student) => student.id == id);
    if (index != -1) {
      studentsList[index] = studentsList[index].copyWith(name: newName);
      studentsList.refresh();
    }
  }

  Future<void> deleteStudent(int studentId) async {
    isLoading.value = true;
    try {
      await ClassService.deleteStudent(studentId);
      studentsList.removeWhere((student) => student.id == studentId);

      Get.snackbar(
        'Sukses',
        'Siswa berhasil dihapus',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      print('Error deleting student: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus siswa: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText:AppStyles.light,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> deleteClass(int classId) async {
    isLoading.value = true;
    try {
      await ClassService.deleteClass(classId);
      await getClasses();

      Get.snackbar(
        'Sukses',
        'Kelas berhasil dihapus',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      print('Error deleting class: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus kelas: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> addUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String longName,
    required String phoneNumber,
    required int classId,
    required String role,
  }) async {
    try {
      isLoading.value = true;

      // final box = GetStorage();
      // final token = box.read('token');
      // if (token == null) {
      //   throw Exception('Token not found. User might not be logged in.');
      // }

      await ClassService.createUser(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        longName: longName,
        phoneNumber: phoneNumber,
        classId: classId,
        role: role,
        // token: token,
      );

      await getStudents(classId);

      Get.back();

    } catch (e) {
      print('Error adding user: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
