import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../components/AppStyles.dart';
import '../../../components/CategoriesLine.dart';
import '../../../components/CustomTextField.dart';
import '../../../components/ReuseButton.dart';
import '../../../components/SectionTile.dart';
import '../../../controllers/subject_controller.dart';

class AddSubject extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final SubjectController controller = Get.find<SubjectController>();

  AddSubject({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppStyles.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppStyles.spaceXXL),
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
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                  SizedBox(width: AppStyles.spaceS),
                  Expanded(
                    child: CategoriesLine(
                      title: 'Add Subject',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppStyles.spaceM),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: 'Nama Mata Pelajaran'),
                    SizedBox(height: AppStyles.spaceS),
                    Customtextfield(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      hintText: 'Nama Mata Pelajaran',
                    ),
                    SizedBox(height: AppStyles.spaceM),
                    ReuseButton(
                      text: 'Add Subject',
                      onPressed: () {
                        controller.addSubject(nameController.text);
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
