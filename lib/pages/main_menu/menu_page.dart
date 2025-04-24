import 'package:flutter/material.dart';
import 'package:gcc_admin/components/BottomNav.dart';
import 'package:gcc_admin/pages/class_page/class_page.dart';
import 'package:gcc_admin/pages/home_page/home_page.dart';
import 'package:gcc_admin/pages/profile_page/profile_page.dart';
import 'package:get/get.dart';

import '../../controllers/menu_controller.dart';

class MainMenu extends StatelessWidget {
  
  final List<Widget> pages = [
    HomePage(),
    ClassPage(),
    ProfilePage(),
  ];
   MainMenu({super.key}) {
    Get.put(MainMenuController()); // Inisialisasi saat MainMenu dibuat
  }
  @override
  Widget build(BuildContext context) {
    MainMenuController controller = Get.find();
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Bottomnav(),
    );
  }
}
