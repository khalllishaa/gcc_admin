import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:get/get.dart';
import '../../../components/CustomTextField.dart';
import '../../../components/ReuseButton.dart';
import '../../../controllers/class_controller.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final controller = Get.find<ClassController>();

  final nameController = TextEditingController();
  final longNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.light,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppStyles.radius),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppStyles.primaryDark,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: AppStyles.light),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    SizedBox(width: AppStyles.spaceS),
                    Expanded(
                      child: CategoriesLine(
                        image: 'images/categories.png',
                        title: 'Add Siswa',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceM),

                SectionTitle(title: 'Nama'),
                Customtextfield(
                  controller: nameController,
                  hintText: 'Username',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: AppStyles.spaceS),

                SectionTitle(title: 'Nama Lengkap'),
                Customtextfield(
                  controller: longNameController,
                  hintText: 'Nama lengkap siswa',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: AppStyles.spaceS),

                SectionTitle(title: 'Email'),
                Customtextfield(
                  controller: emailController,
                  hintText: 'Email siswa',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: AppStyles.spaceS),

                SectionTitle(title: 'Nomor HP'),
                Customtextfield(
                  controller: phoneController,
                  hintText: 'Nomor HP',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: AppStyles.spaceS),

                SectionTitle(title: 'Password'),
                Customtextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: AppStyles.spaceS),

                SectionTitle(title: 'Kofirmasi Password'),
                Customtextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: AppStyles.space),

                ReuseButton(
                  text: 'Add Student',
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        longNameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Semua field harus diisi.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.error,
                        colorText: AppStyles.light,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(16),
                      );
                      return;
                    }

                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      Get.snackbar(
                        'Error',
                        'Password tidak cocok.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.error,
                        colorText: AppStyles.light,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(16),
                      );                      return;
                    }

                    try {
                      final selectedClass = controller.classList.firstWhere(
                            (cls) =>
                        cls.name == controller.selectedClassName.value,
                      );

                      await controller.addUser(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        passwordConfirmation: confirmPasswordController.text,
                        longName: longNameController.text,
                        phoneNumber: phoneController.text,
                        classId: selectedClass.id,
                        role: 'student',
                      );

                      Get.snackbar(
                        'Sukses',
                        'User berhasil ditambahkan!',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.welcome,
                        colorText: AppStyles.dark,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(16),
                      );
                      Get.back();
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Gagal menambahkan siswa: $e',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppStyles.error,
                        colorText: AppStyles.light,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(16),
                      );
                    }
                  },
                ),
                SizedBox(height: AppStyles.spaceL),

              ],
            ),
          ),
        ),
      ),
    );
  }
}