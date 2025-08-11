import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/models/journal_model.dart';
import '../data/services/journal_service.dart';
import '../pages/home_page/journal/journal.dart';

class JournalController extends GetxController {
  RxList<JournalModel> journals = <JournalModel>[].obs;
  RxList<JournalModel> filteredJournals = <JournalModel>[].obs;
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  var selectedClassId = 0.obs;
  final teacherId = 0.obs;
  final subjectId = 0.obs;
  final classroomId = 0.obs;
  var postSuccess = false.obs;
  var journal = Rxn<JournalModel>();
  var errorMessage = ''.obs;

  // Journal ID yang akan diambil
  int? journalId;

  // Property untuk file path
  RxString filePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize dengan tanggal hari ini
    selectedDate.value = DateTime.now();

    // // Ambil data journal dari arguments atau parameter
    // final arguments = Get.arguments;
    //
    // if (arguments != null) {
    //   if (arguments is Journal) {
    //     // Jika langsung dikirim object Journal
    //     journal.value = arguments;
    //   } else if (arguments is Map && arguments['id'] != null) {
    //     // Jika dikirim Map dengan key 'id'
    //     journalId = arguments['id'];
    //     fetchJournalById(journalId!);
    //   } else if (arguments is int) {
    //     // Jika langsung dikirim ID
    //     journalId = arguments;
    //     fetchJournalById(journalId!);
    //   }
    // }
    //
    // // Jika tidak ada arguments, coba ambil dari parameters
    // if (journal.value == null && journalId == null) {
    //   final String? idParam = Get.parameters['id'];
    //   if (idParam != null) {
    //     journalId = int.tryParse(idParam);
    //     if (journalId != null) {
    //       fetchJournalById(journalId!);
    //     }
    //   }
    // }
  }

  // Method untuk reset form setelah submit
  void resetForm() {
    teacherId.value = 0;
    subjectId.value = 0;
    filePath.value = '';
    postSuccess.value = false;
  }

  Future<void> submitJournal() async {
    print("Submitting journal...");
    isLoading.value = true;

    try {
      final model = CreateJournalModel(
        classroomId: classroomId.value,
        subjectId: subjectId.value,
        teacherId: teacherId.value,
        filePath: filePath.value.isEmpty ? null : filePath.value,
      );

      final success = await JournalService.postJournal(model);
      print("Journal submission status: $success");

      postSuccess.value = success;

      if (success) {
        Get.snackbar(
          'Sukses',
          'Journal berhasil ditambahkan!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppStyles.welcome,
          colorText: AppStyles.dark,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(16),
        );

        // Reset form setelah berhasil
        resetForm();

        await Future.delayed(Duration(seconds: 1));
        Get.back(result: true);
      } else {
        Get.snackbar(
          'Error',
          'Gagal menambahkan journal.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppStyles.error,
          colorText: AppStyles.light,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      print('Error in submitJournal: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppStyles.error,
        colorText: AppStyles.light,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchJournals() async {
    if (selectedClassId.value == 0) {
      print('Class ID not set, skipping fetch');
      return;
    }

    isLoading.value = true;
    try {
      final dateString = DateFormat('yyyy-MM-dd').format(selectedDate.value);
      print('Fetching journals for classId: ${selectedClassId.value}, date: $dateString');

      final allData = await JournalService.fetchJournals(
        classId: selectedClassId.value,
        date: dateString,
      );

      print('Fetched ${allData.length} journals from API');
      journals.value = allData;

      // Filter journals setelah data diterima
      filterJournals();
    } catch (e) {
      print('Error fetching journals: $e');
      // Set empty list jika error
      journals.value = [];
      filteredJournals.value = [];

      Get.snackbar(
        'Error',
        'Gagal memuat data journal',
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

  void setDate(DateTime date) {
    // Normalize date to start of day untuk konsistensi
    final normalizedDate = DateTime(date.year, date.month, date.day);
    selectedDate.value = normalizedDate;

    final dateString = DateFormat('yyyy-MM-dd').format(normalizedDate);
    print('Date selected: $dateString');

    // Clear existing filtered data
    filteredJournals.value = [];

    // Fetch journals untuk tanggal yang dipilih
    if (selectedClassId.value != 0) {
      fetchJournals();
    }
  }

  void setClassId(int id) {
    selectedClassId.value = id;
    print('Class ID set to: $id');

    // Clear existing data
    journals.value = [];
    filteredJournals.value = [];

    // Fetch journals untuk class yang dipilih
    fetchJournals();
  }

  void filterJournals() {
    if (journals.isEmpty) {
      filteredJournals.value = [];
      print('No journals to filter');
      return;
    }

    final selectedDateString = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    print('Filtering journals for date: $selectedDateString and classId: ${selectedClassId.value}');

    try {
      filteredJournals.value = journals.where((journal) {
        try {
          // Normalize journal date untuk perbandingan
          final journalDate = DateTime(
              journal.createdAt.year,
              journal.createdAt.month,
              journal.createdAt.day
          );
          final journalDateString = DateFormat('yyyy-MM-dd').format(journalDate);

          final dateMatch = journalDateString == selectedDateString;
          final classMatch = journal.classroomId == selectedClassId.value;

          print('Journal ${journal.id}: date=$journalDateString (match: $dateMatch), class=${journal.classroomId} (match: $classMatch)');

          return dateMatch && classMatch;
        } catch (e) {
          print('Error filtering journal ${journal.id}: $e');
          return false;
        }
      }).toList();

      print('Filtered journals count: ${filteredJournals.length}');

      // Sort berdasarkan waktu terbaru
      filteredJournals.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    } catch (e) {
      print('Error in filterJournals: $e');
      filteredJournals.value = [];
    }
  }

  // Method untuk refresh data
  Future<void> refreshData() async {
    print('Refreshing journal data...');
    await fetchJournals();
  }

  // Method untuk debug
  void debugInfo() {
    print('=== DEBUG INFO ===');
    print('Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate.value)}');
    print('Selected Class ID: ${selectedClassId.value}');
    print('Total Journals: ${journals.length}');
    print('Filtered Journals: ${filteredJournals.length}');
    print('Is Loading: ${isLoading.value}');
    print('==================');
  }

  // -----

// // Method untuk mengambil detail journal berdasarkan ID
//   Future<void> fetchJournalById(int id) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//
//       final result = await JournalService.getJournalById(id);
//       journal.value = result;
//       print('DEBUG: filePath = ${result.filePath}');
//       print("DEBUG >> filePath from API: ${result.filePath}");
//       print("DEBUG >> Full journal data: ${result.toJson()}");
//
//     } catch (e) {
//       errorMessage.value = e.toString();
//       print('Error fetching journal detail: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

  // Method untuk refresh data
  // Future<void> refreshJournal() async {
  //   if (journalId != null) {
  //     await fetchJournalById(journalId!);
  //   } else if (journal.value != null) {
  //     await fetchJournalById(journal.value!.id);
  //   }
  // }

  // Method untuk mendapatkan formatted date

  String getFormattedDate() {
    final journalData = journal.value;
    if (journalData == null || journalData.createdAt == null) return '';

    try {
      return DateFormat('dd MMMM yyyy', 'id_ID').format(journalData.createdAt);
    } catch (e) {
      return '';
    }
  }

  // Method untuk mendapatkan subject name
  String getSubjectName() {
    return journal.value?.subject.name ?? 'Unknown Subject';
  }

  // Method untuk mendapatkan teacher name
  String getTeacherName() {
    return journal.value?.teacher.name ?? 'Unknown Teacher';
  }

  // Method untuk mendapatkan classroom name
  String getClassroomName() {
    return journal.value?.classroom.name ?? 'Unknown Classroom';
  }

  String getJournalContent() {
    if (journal.value?.description != null && journal.value!.description!.isNotEmpty) {
      return journal.value!.description!;
    } else if (journal.value?.filePath != null && journal.value!.filePath!.isNotEmpty) {
      return "Download File";
    }
    print("DEBUG >> filePath: ${journal.value?.filePath}");
    return 'No content available';
  }


  // Method untuk cek apakah journal memiliki file
  bool hasFile() {
    return journal.value?.filePath != null && journal.value!.filePath!.isNotEmpty;
  }

  void onFileAction() async {
    if (hasFile()) {
      final String filePath = journal.value!.filePath!;
      // final String fullUrl = "${endpoint.baseUrl}/storage/$filePath";
      final String fullUrl = "https://gcc-api.rplrus.com/$filePath";


      final Uri fileUri = Uri.parse(fullUrl);

      if (await canLaunchUrl(fileUri)) {
        await launchUrl(fileUri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Gagal Membuka File',
          'Tidak bisa membuka file: $fullUrl',
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        'No File',
        'Tidak ada file pada jurnal ini',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // void onFileAction() {
  //   if (hasFile()) {
  //     final filePath = journal.value!.filePath!;
  //     final url = "https://gcc-api.rplrus.com/$filePath";
  //
  //     // Cek apakah PDF
  //     if (filePath.toLowerCase().endsWith('.pdf')) {
  //       Get.to(() => PDFViewerPage(url: url));
  //     } else {
  //       // fallback ke launcher
  //       launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  //     }
  //   } else {
  //     Get.snackbar('No File', 'Tidak ada file pada jurnal ini');
  //   }
  // }

  // Method untuk navigasi kembali
  void goBack() {
    Get.back();
  }

  // Method untuk handle error retry
  // void retryFetch() {
  //   if (journalId != null) {
  //     fetchJournalById(journalId!);
  //   }
  // }

  Future<void> refreshJournal() async {
    if (journalId != null) {
      await fetchJournalById(journalId!);
    } else if (journal.value != null) {
      await fetchJournalById(journal.value!.id);
    }
  }

  Future<void> fetchJournalById(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await JournalService.getJournalById(id);
      journal.value = result;

      print('DEBUG: filePath = ${result.filePath}');
      print("DEBUG >> filePath from API: ${result.filePath}");
      print("DEBUG >> Full journal data: ${result.toJson()}");

    } catch (e) {
      errorMessage.value = e.toString();
      print('Error fetching journal detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

}