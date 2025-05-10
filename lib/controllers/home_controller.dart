import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  // String userName = 'Khalisha';

  var classData = <Map<String, dynamic>>[
    {
      "title": "Matematika",
      "teacher": "Miss Ica",
      "time": "13.00 - 14.30",
      "topic": "Kombinasi",
      "icon": Icons.calculate,
    },
    {
      "title": "Bahasa Inggris",
      "teacher": "Miss Ica",
      "time": "13.00 - 14.30",
      "topic": "Proposal",
      "icon": Icons.menu_book_rounded,
    },
    {
      "title": "Fisika",
      "teacher": "Miss Ica",
      "time": "13.00 - 14.30",
      "topic": "Gravitasi",
      "icon": Icons.science_rounded,
    },
  ].obs;

  var selectedIndex = 0.obs;
  var username = Rxn<String>(); // Allows null-safe Rx value

  void updateIndex(int index) {
    if (index != selectedIndex.value) {
      selectedIndex.value = index; // Update only if the index changes
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchSharedData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    print("shared data "+sharedPreferences.getString('username').toString());
    username.value = sharedPreferences.getString('username')!;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchSharedData();
  }
}