import 'package:flutter/material.dart';
import 'package:gcc_admin/components/ReportCard.dart';
import 'package:get/get.dart';

class ViewReport extends StatelessWidget {
  const ViewReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
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
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 151, 159, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Journal 13 Januari 2025",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AssessmentCard(subject: 'Bahasa Indonesia'),
            AssessmentCard(subject: 'Matematika'),
            AssessmentCard(subject: 'IPA'),
          ],
        ),
      ),
    );
  }
}
