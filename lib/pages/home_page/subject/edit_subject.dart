import 'package:flutter/material.dart';
import 'package:gcc_admin/data/models/subject_model.dart';
import 'package:get/get.dart';
import '../../../components/AppStyles.dart';
import '../../../components/CategoriesLine.dart';
import '../../../components/CustomTextField.dart';
import '../../../components/ReuseButton.dart';
import '../../../components/SectionTile.dart';
import '../../../controllers/subject_controller.dart';

class EditSubject extends StatelessWidget {
  EditSubject({super.key});

  final SubjectController controller = Get.find();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SubjectModel subject = Get.arguments;
    nameController.text = subject.name;

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
                      title: 'Edit Subject',
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
                      hintText: 'PPKN',
                    ),
                    SizedBox(height: AppStyles.spaceM),
                    ReuseButton(
                      text: 'Simpan Perubahan',
                      onPressed: () {
                        final newName = nameController.text.trim();
                        if (newName.isNotEmpty) {
                          controller.editSubject(subject.id, newName);
                          Get.back();
                        } else {
                          Get.snackbar('Gagal', 'Nama tidak boleh kosong');
                        }
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
