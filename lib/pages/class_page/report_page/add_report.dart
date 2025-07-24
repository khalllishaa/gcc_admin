import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/CustomTextField.dart';
import '../../../controllers/reports_controller.dart';

class AddReportView extends StatelessWidget {
  final controller = Get.put(ReportController());
  final int userId = Get.arguments['userId'];

  AddReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Tambah Laporan"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.subjects.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: controller.subjects.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    if (index < controller.subjects.length) {
                      final subject = controller.subjects[index];

                      return Obx(() {
                        final selectedRating = controller.ratings.value[subject.id];

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Tingkat Pemahaman",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: controller.ratingOptions.map((rating) {
                                  final selected = selectedRating == rating;
                                  return GestureDetector(
                                    onTap: () => controller.setRating(subject.id, rating),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: selected ? Colors.teal : Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        rating,
                                        style: TextStyle(
                                          color: selected ? Colors.white : Colors.black87,
                                          fontSize: 13,
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

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Catatan",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Customtextfield(
                            controller: controller.noteController,
                            hintText: 'Catatan',
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ✅ BUTTON SUBMIT
              Obx(() {
                final alreadySubmitted = controller.hasSubmittedReport(userId);
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: Text(
                      alreadySubmitted
                          ? "Sudah Mengirim Laporan"
                          : "Kirim Laporan",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: alreadySubmitted ? Colors.grey : Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: alreadySubmitted
                        ? null
                        : () async {
                      try {
                        controller.isLoading.value = true;
                        await controller.submitReports(userId);
                        controller.isLoading.value = false;

                        Get.back();
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
                    },
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
