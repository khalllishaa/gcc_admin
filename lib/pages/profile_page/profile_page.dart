import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/ProfileItem.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/ProfileImage.dart';
import '../../controllers/journal_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();

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
            child: RefreshIndicator(
              onRefresh: () async {
                final userId = controller.user.value?.id;
                if (userId != null) {
                  await controller.fetchCurrentUser();
                }
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppStyles.light,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppStyles.radius),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppStyles.paddingXL,
                    vertical: 84,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        final isPicked = controller.isImagePicked.value;
                        final pickedPath = controller.profileImage.value;
                        final user = controller.user.value;

                        ImageProvider imageProvider;

                        if (isPicked && pickedPath.isNotEmpty) {
                          imageProvider = FileImage(File(pickedPath));
                        } else if (user?.profilePicture != null && user!.profilePicture!.isNotEmpty) {
                          try {
                            final path = user.profilePicture;
                            final url = 'https://gcc-api.rplrus.com/$path';
                            imageProvider = NetworkImage(url);
                          } catch (e) {
                            imageProvider = AssetImage('images/profile.png');
                          }
                        } else {
                          imageProvider = AssetImage('images/profile.png');
                        }

                        return ProfileImagePicker(
                          image: imageProvider,
                          onPickFromCamera: () => controller.pickImage(ImageSource.camera),
                          onPickFromGallery: () => controller.pickImage(ImageSource.gallery),
                        );
                      }),
                      SizedBox(height: AppStyles.spaceS),
                      Obx(() {
                        final user = controller.user.value;
                        // final journalController = Get.find<JournalController>();
                        // final filteredJournals = journalController.getFilteredJournals();
                        //
                        // final kelas = filteredJournals.isNotEmpty
                        //     ? filteredJournals.first.classroom?.name ?? 'Kelas tidak diketahui'
                        //     : 'Kelas tidak diketahui';

                        if (user == null) return CircularProgressIndicator();

                        return Column(
                          children: [
                            Text(
                              user.longName,
                              style: AppStyles.welcome2.copyWith(
                                color: AppStyles.dark,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              user.email,
                              style: AppStyles.lesson.copyWith(color: AppStyles.dark),
                            ),
                            SizedBox(height: AppStyles.spaceL),
                            ProfileItem(textPrimary: 'Nama Panjang', textSecond: user.longName),
                            ProfileItem(textPrimary: 'No. Telepon', textSecond: user.phoneNumber),
                            // ProfileItem(textPrimary: 'Kelas', textSecond: kelas),
                          ],
                        );
                      }),
                      SizedBox(height: AppStyles.spaceL),
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
            ),
          ),
        ],
      ),
    );
  }
}
