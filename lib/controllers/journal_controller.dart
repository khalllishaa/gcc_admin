import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../data/models/journal_model.dart';
import '../data/services/journal_service.dart';

class JournalController extends GetxController {
  RxList<JournalModel> journals = <JournalModel>[].obs;
  RxList<JournalModel> filteredJournals = <JournalModel>[].obs;
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  var selectedClassId = 0.obs;
  final teacherId = 0.obs;
  final subjectId = 0.obs;
  final classroomId = 0.obs;
  // final filePath = ''.obs;
  var postSuccess = false.obs;
  // RxString filePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> submitJournal() async {
    print("Submitting journal...");
    final model = CreateJournalModel(
      classroomId: classroomId.value,
      subjectId: subjectId.value,
      teacherId: teacherId.value,
      // filePath: filePath.value.isEmpty ? null : filePath.value,
    );

    final success = await JournalService.postJournal(model);
    print("Journal submission status: $success");

    postSuccess.value = success;

    if (success) {
      postSuccess.value = true;

      Get.snackbar(
        'Sukses',
        'Materi berhasil ditambahkan!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.welcome,
        colorText: AppStyles.dark,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );
      await Future.delayed(Duration(seconds: 1));
      Get.back(result: true);
    } else {
      Get.snackbar(
        'Error',
        'Gagal menambahkan materi.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      );    }
  }


  Future<void> fetchJournals() async {
    isLoading.value = true;
    try {
      final allData = await JournalService.fetchJournals(
        classId: 0,
        date: '',
      );
      journals.value = allData;
      filterJournals();
    } catch (e) {
      print('Error fetching journals: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    filterJournals();
  }

  void setClassId(int id) {
    selectedClassId.value = id;
    fetchJournals(); // Ambil ulang dan filter
  }

  void filterJournals() {
    final date = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    filteredJournals.value = journals.where((journal) {
      final journalDate = DateFormat('yyyy-MM-dd').format(journal.createdAt);
      return journalDate == date && journal.classroomId == selectedClassId.value;
    }).toList();
  }

}
