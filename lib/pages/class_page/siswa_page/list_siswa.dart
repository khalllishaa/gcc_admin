import 'package:flutter/material.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/StudentCard.dart';
import 'package:get/get.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // SafeArea ditambahkan di sini
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 151, 159, 1),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: CategoriesLine(
                        image: 'images/categories.png',
                        title: 'Kelas',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                StudentCard(
                  name: 'Murid 1',
                  onEdit: () => Get.toNamed('/edit-siswa'),
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 2',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 3',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 4',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 5',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 6',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 7',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 8',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
                StudentCard(
                  name: 'Murid 9',
                  onEdit: () {},
                  onDelete: () {},
                  onMore: () => Get.toNamed('/list-report'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-siswa'),
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromRGBO(55, 171, 177, 1)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
