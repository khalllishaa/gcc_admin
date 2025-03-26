import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String userName = 'Khalisha';

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
}