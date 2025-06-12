import 'package:get/get.dart';
import '../components/AppStyles.dart';
import '../data/models/subject_model.dart';
import '../data/services/subject_service.dart';

class SubjectController extends GetxController {
  var subjects = <SubjectModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchSubjects();
    super.onInit();
  }

  void fetchSubjects() async {
    try {
      isLoading.value = true;
      var result = await SubjectService().fetchSubjects();
      print("Fetched subjects from service: $result");
      subjects.value = result;
    } catch (e) {
      print("Error fetching subjects: $e");
      Get.snackbar('Error', 'Failed to fetch subjects');
    } finally {
      isLoading.value = false;
    }
  }

  void addSubject(String name) async {
    try {
      isLoading.value = true;
      await SubjectService().addSubject(name);
      fetchSubjects();
      Get.snackbar('Success', 'Subject berhasil ditambahkan');
    } catch (e) {
      print('Error addSubject: $e');
      Get.snackbar('Error', 'Gagal menambahkan subject');
    } finally {
      isLoading.value = false;
    }
  }

  void editSubject(int id, String name) async {
    try {
      isLoading.value = true;
      await SubjectService().editSubject(id, name);
      fetchSubjects();
      Get.snackbar('Success', 'Subject berhasil diupdate');
    } catch (e) {
      print('Error editSubject: $e');
      Get.snackbar('Error', 'Gagal mengupdate subject');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteSubject(int id) async {
    try {
      isLoading.value = true;
      await SubjectService().deleteSubject(id);
      fetchSubjects();
      Get.snackbar(
        'Sukses',
        'Subject berhasil dihapus',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      print('Error deleteSubject: $e');
      Get.snackbar(
        'Error',
        'Gagal menghapus subject: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText:AppStyles.light,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSubjects() async {
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 1));
      subjects.refresh();
    } finally {
      isLoading.value = false;
    }
  }

}
