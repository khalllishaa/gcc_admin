import 'package:get/get.dart';
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
      Get.snackbar('Berhasil', 'Guru ditambahkan');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteTeacher(int id) async {
    try {
      await _teacherService.deleteTeacher(id);
      teachers.removeWhere((t) => t.id == id);
      Get.snackbar('Berhasil', 'Guru dihapus');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void editTeacher(int index) {
    Get.toNamed('/edit-teacher', arguments: teachers[index]);
  }
}
