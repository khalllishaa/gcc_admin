import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/ProfileItem.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/ProfileImage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppStyles.primary,
      body: Column(
        children: [
          SizedBox(height: AppStyles.spaceXXL),
          Center(
            child: Text(
              "Profile",
              style: AppStyles.headingStyle.copyWith(fontSize: 24),
            ),
          ),
          SizedBox(height: AppStyles.spaceL),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.radius)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => ProfileImagePicker(
                    image: controller.isImagePicked.value
                        ? FileImage(File(controller.profileImage.value))
                        : const AssetImage('images/profile.png') as ImageProvider,
                    onPickFromCamera: () => controller.pickImage(ImageSource.camera),
                    onPickFromGallery: () => controller.pickImage(ImageSource.gallery),
                  )),
                  SizedBox(height: AppStyles.spaceS),
                  Text(
                    "oceantheteacher",
                    style:AppStyles.welcome2.copyWith(color: AppStyles.dark, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "oceantheteacher@gmail.com",
                    style: AppStyles.lesson.copyWith(color: AppStyles.dark),
                  ),
                  SizedBox(height: AppStyles.spaceL),
                  // Profile Information
                  ProfileItem(textPrimary: 'Nama Panjang', textSecond: 'Ocean Karuna Muryanto'),
                  ProfileItem(textPrimary: 'No. Telepon', textSecond: '+62 89618488091'),
                  ProfileItem(textPrimary: 'Kelas', textSecond: '8'),
                  Spacer(),
                  ReuseButton(
                    text: 'Sign Out',
                    onPressed: () {
                      controller.logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
