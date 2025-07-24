// import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/CategoriesLine.dart';
import 'package:gcc_admin/components/CustomTextField.dart';
import 'package:gcc_admin/components/ReuseButton.dart';
import 'package:gcc_admin/components/SectionTile.dart';
import 'package:gcc_admin/components/TextField2.dart';
import 'package:gcc_admin/controllers/menu_controller.dart';
import 'package:get/get.dart';

import '../../../controllers/journal_controller.dart';
import '../../../controllers/schedule_controller.dart';
import '../../../controllers/subject_controller.dart';
import '../teacher/add_teacher.dart';

class AddJournal extends StatelessWidget {
  const AddJournal({super.key});

  @override
  Widget build(BuildContext context) {
    JournalController journalController = Get.find();
    SubjectController subjectController = Get.put(SubjectController());
    ScheduleController controller = Get.put(ScheduleController());
    subjectController.getSubjects();
    final RxInt selectedTeacherId = 0.obs;
    final RxInt selectedSubjectId = 0.obs;
    final args = Get.arguments;

    journalController.classroomId.value = args['classId'];

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
                      title: 'Add Journal',
                      image: 'images/categories.png',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'Teacher'),
                    SizedBox(height: AppStyles.spaceS),
                    // ),
                    Obx(() => DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: AppStyles.paddingXL, vertical: AppStyles.paddingL),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppStyles.radius),
                          borderSide: BorderSide(color: AppStyles.primary, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppStyles.radius),
                          borderSide: BorderSide(color: AppStyles.primary, width: 1.5),
                        ),
                        filled: true,
                        fillColor: AppStyles.primaryLight.withOpacity(0.1),
                        hintText: 'Select Teacher',
                        hintStyle: TextStyle(color: AppStyles.grey1),
                      ),
                      dropdownColor: AppStyles.light,
                      borderRadius: BorderRadius.circular(AppStyles.radius),
                      value: selectedTeacherId.value == 0 ? null : selectedTeacherId.value,
                      items: controller.teachers
                          .map((teacher) => DropdownMenuItem(
                        value: teacher.id,
                        child: Text(teacher.name, style: AppStyles.profileText2),
                      ))
                          .toList(),
                      onChanged: (value) {
                        selectedTeacherId.value = value!;
                      },
                    )),
                    SizedBox(height: AppStyles.spaceS),
                    SectionTitle(title: 'Subject'),
                    SizedBox(height: AppStyles.spaceS),
                    Obx(() => DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: AppStyles.paddingXL, vertical: AppStyles.paddingL),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppStyles.radius),
                          borderSide: BorderSide(color: AppStyles.primary, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppStyles.radius),
                          borderSide: BorderSide(color: AppStyles.primary, width: 1.5),
                        ),
                        filled: true,
                        fillColor: AppStyles.primaryLight.withOpacity(0.1),
                        hintText: 'Select Subject',
                        hintStyle: TextStyle(color: AppStyles.grey1),
                      ),
                      dropdownColor: AppStyles.light,
                      borderRadius: BorderRadius.circular(AppStyles.radius),
                      value: selectedSubjectId.value == 0 ? null : selectedSubjectId.value,
                      items: subjectController.subjects
                          .map((subject) => DropdownMenuItem(
                        value: subject.id,
                        child: Text(subject.name, style: AppStyles.profileText2),
                      ))
                          .toList(),
                      onChanged: (value) {
                        selectedSubjectId.value = value!;
                      },
                    )),
                    SizedBox(height: AppStyles.spaceM),
                    // ReuseButton(
                    //   text: 'Submit Journal',
                    //   onPressed: () async {
                    //     await journalController.submitJournal();
                    //   },
                    // ),
                    // Obx(() => Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SectionTitle(title: 'Upload File (Optional)'),
                    //     SizedBox(height: AppStyles.spaceS),
                    //     ElevatedButton.icon(
                    //       onPressed: () async {
                    //         FilePickerResult? result = await FilePicker.platform.pickFiles();
                    //
                    //         if (result != null) {
                    //           journalController.filePath.value = result.files.single.path!;
                    //         }
                    //       },
                    //       icon: Icon(Icons.attach_file),
                    //       label: Text(journalController.filePath.value.isEmpty
                    //           ? 'Choose File'
                    //           : 'File selected'),
                    //     ),
                    //     if (journalController.filePath.value.isNotEmpty)
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 8),
                    //         child: Text(
                    //           journalController.filePath.value.split('/').last,
                    //           style: TextStyle(fontSize: 12, color: AppStyles.grey1),
                    //         ),
                    //       ),
                    //   ],
                    // )),
                    // SectionTitle(title: 'Task'),
                    // SizedBox(height: AppStyles.spaceS),
                    // Textfield2(
                    //   controller: TextEditingController(),
                    //   keyboardType: TextInputType.text,
                    //   hintText: "Task",
                    //   onUploadPressed: () {
                    //   },
                    // ),
                    SectionTitle(title: 'Upload File (Optional)'),
                    SizedBox(height: AppStyles.spaceS),
                    // Obx(() => Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     ElevatedButton.icon(
                    //       onPressed: () async {
                    //         FilePickerResult? result = await FilePicker.platform.pickFiles(
                    //           withData: true, // Web butuh ini kadang
                    //         );
                    //
                    //         if (result != null && result.files.single.path != null) {
                    //           journalController.filePath.value = result.files.single.path!;
                    //         }
                    //       },
                    //       icon: Icon(Icons.attach_file),
                    //       label: Text(
                    //         journalController.filePath.value.isEmpty
                    //             ? 'Choose File'
                    //             : 'Change File',
                    //       ),
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: AppStyles.primaryDark,
                    //         foregroundColor: AppStyles.light,
                    //       ),
                    //     ),
                    //     if (journalController.filePath.value.isNotEmpty)
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 8),
                    //         child: Text(
                    //           "Selected: ${journalController.filePath.value.split('/').last}",
                    //           style: TextStyle(fontSize: 12, color: AppStyles.grey1),
                    //         ),
                    //       ),
                    //   ],
                    // )),
                    SizedBox(height: AppStyles.spaceL),
                    SizedBox(height: AppStyles.spaceL),
                    ReuseButton(
                        text: 'Submit Journal',
                        onPressed: () async {
                          journalController.teacherId.value = selectedTeacherId.value;
                          journalController.subjectId.value = selectedSubjectId.value;

                          await journalController.submitJournal();

                          if (journalController.postSuccess.value) {
                            Navigator.pop(context);
                          }
                        }
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