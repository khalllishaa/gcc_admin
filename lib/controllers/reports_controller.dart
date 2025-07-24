import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/reports_model.dart';
import '../data/models/subject_model.dart';
import '../data/services/reports_service.dart';
import '../data/services/subject_service.dart';

class ReportController extends GetxController {
  final noteController = TextEditingController();
  var allReports = <Report>[].obs;
  // var selectedMonth = ''.obs;
  var selectedMonth = RxString(monthNames[DateTime.now().month - 1]);
  var isLoading = false.obs;

  var subjects = <SubjectModel>[].obs;
  var ratings = <int, String>{}.obs;

  final ratingOptions = [
    'Perlu Ditingkatkan',
    'Baik',
    'Sangat Baik',
  ];

  @override
  void onInit() {
    super.onInit();
    loadSubjects();
    loadReports();
  }

  Future<void> fetchReports() async {
    isLoading.value = true;
    try {
      final data = await ReportService.fetchReports(); // ✅ sesuai yg udah kamu pakai
      allReports.assignAll(data); // ✅ pakai variabel yang bener
    } catch (e) {
      print("Error saat fetchReports: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadSubjects() async {
    try {
      final data = await SubjectService().fetchSubjects();
      subjects.value = data;
    } catch (e) {
      print("Gagal load subject: $e");
    }
  }

  void loadReports() async {
    try {
      allReports.value = await ReportService.fetchReports();
    } catch (e) {
      print("Error fetching reports: $e");
    }
  }

  void setRating(int subjectId, String rating) {
    ratings[subjectId] = rating;
  }

  List<Map<String, dynamic>> getSelectedReports() {
    return ratings.entries.map((entry) {
      return {
        'subject_id': entry.key,
        'rating': entry.value,
        'note': entry.value,
      };
    }).toList();
  }

  // Future<void> submitReports(int userId) async {
  //   final selected = getSelectedReports();
  //   if (selected.isEmpty) throw Exception("Belum ada yang dipilih");
  //   await ReportService.submitReports(userId: userId, reports: selected);
  // }

  bool hasSubmittedReport(int userId) {
    final now = DateTime.now();
    return allReports.any((r) =>
    r.user.id == userId &&
        r.createdAt.year == now.year &&
        r.createdAt.month == now.month);
  }

  // Future<void> submitReports(int userId) async {
  //   if (ratings.length != subjects.length) {
  //     throw Exception("Semua mata pelajaran harus diisi rating-nya");
  //   }
  //
  //   final selected = getSelectedReports();
  //   await ReportService.submitReports(userId: userId, reports: selected);
  // }

  Future<void> submitReports(int userId) async {
    if (ratings.length != subjects.length) {
      throw Exception("Semua mata pelajaran harus diisi rating-nya");
    }

    final selected = getSelectedReports();
    final note = noteController.text.trim();

    await ReportService.submitReports(
      userId: userId,
      reports: selected,
      note: note,
    );
  }


  List<Report> getFilteredReports(int userId) {
    if (selectedMonth.value.isEmpty) {
      return allReports.where((r) => r.user.id == userId).toList();
    }

    int selectedMonthIndex = monthNames.indexOf(selectedMonth.value) + 1;
    return allReports.where((r) =>
    r.user.id == userId && r.createdAt.month == selectedMonthIndex).toList();
  }
}

List<String> monthNames = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
];
