import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/AppStyles.dart';
import '../../../components/CategoriesLine.dart';
import '../../../components/CustomTextField.dart';
import '../../../components/ReuseButton.dart';
import '../../../controllers/reports_controller.dart';

class AddReportView extends StatelessWidget {
  final controller = Get.put(ReportController());
  final int userId = Get.arguments['userId'];

  AddReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.light,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: Column(
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
                      title: 'Add Reports',
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppStyles.spaceM),

              // === CONTENT LIST ===
              Expanded(
                child: Obx(() {
                  if (controller.subjects.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.separated(
                    padding: EdgeInsets.only(bottom: AppStyles.paddingXL),
                    itemCount: controller.subjects.length + 2,
                    separatorBuilder: (_, __) => SizedBox(height: AppStyles.spaceM),
                    itemBuilder: (context, index) {
                      // === SUBJECTS ===
                      if (index < controller.subjects.length) {
                        final subject = controller.subjects[index];

                        return Obx(() {
                          final selectedRating = controller.ratings[subject.id];

                          return Container(
                            padding: EdgeInsets.all(AppStyles.paddingL),
                            decoration: BoxDecoration(
                              color: AppStyles.secondaryLight,
                              borderRadius: BorderRadius.circular(AppStyles.radiusL),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(subject.name, style: AppStyles.report1),
                                SizedBox(height: AppStyles.spaceS),
                                Text("Tingkat Pemahaman Anak:",
                                    style: AppStyles.profileText1.copyWith(fontWeight: FontWeight.w500)),
                                SizedBox(height: AppStyles.spaceS),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: controller.ratingOptions.map((rating) {
                                    final selected = selectedRating == rating;
                                    return GestureDetector(
                                      onTap: () => controller.setRating(subject.id, rating),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppStyles.paddingM, vertical: AppStyles.paddingS),
                                        decoration: BoxDecoration(
                                          color: selected ? AppStyles.primaryLight : AppStyles.light,
                                          borderRadius: BorderRadius.circular(AppStyles.radiusXXL),
                                        ),
                                        child: Text(
                                          rating,
                                          style: AppStyles.report1.copyWith(
                                            color: selected ? AppStyles.light : AppStyles.dark,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        });
                      }

                      // === CATATAN ===
                      if (index == controller.subjects.length) {
                        return Container(
                          padding: EdgeInsets.all(AppStyles.paddingL),
                          decoration: BoxDecoration(
                            color: AppStyles.secondaryLight,
                            borderRadius: BorderRadius.circular(AppStyles.radiusL),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Catatan", style: AppStyles.report1),
                              SizedBox(height: AppStyles.spaceS),
                              Customtextfield(
                                controller: controller.noteController,
                                hintText: '',
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        );
                      }

                      return Obx(() {
                        final alreadySubmitted = controller.hasSubmittedReport(userId);
                        final isLoading = controller.isLoading.value;

                        final canSubmit = !alreadySubmitted && !isLoading;

                        return Padding(
                          padding: EdgeInsets.only(top: AppStyles.spaceM),
                          child: ReuseButton(
                            text: alreadySubmitted
                                ? "Sudah Mengirim Laporan"
                                : isLoading
                                ? "Mengirim..."
                                : "Kirim Laporan",
                            backgroundColor: canSubmit ? AppStyles.primaryDark :AppStyles.grey3,
                            textColor: AppStyles.light,
                            onPressed: canSubmit
                                ? () async {
                              try {
                                controller.isLoading.value = true;
                                await controller.submitReports(userId);
                                controller.isLoading.value = false;

                                Get.back();
                                // Get.toNamed('/add-report', arguments: {'userId': userId});
                                Get.snackbar("Sukses", "Laporan berhasil dikirim",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green.shade100,
                                    colorText: Colors.black);
                              } catch (e) {
                                controller.isLoading.value = false;
                                Get.snackbar("Gagal", e.toString(),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red.shade100,
                                    colorText: Colors.black);
                              }
                            }
                                : () {},
                          ),
                        );
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
