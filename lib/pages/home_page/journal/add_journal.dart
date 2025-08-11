import 'package:file_picker/file_picker.dart';
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
                    
                    // File Upload Section
                    SectionTitle(title: 'Upload File (Optional)'),
                    SizedBox(height: AppStyles.spaceS),
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppStyles.primary,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(AppStyles.radius),
                            color: AppStyles.primaryLight.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppStyles.paddingL),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 48,
                                  color: AppStyles.primary,
                                ),
                                SizedBox(height: AppStyles.spaceS),
                                if (journalController.filePath.value.isEmpty) ...[
                                  Text(
                                    'Choose a file to upload',
                                    style: TextStyle(
                                      color: AppStyles.grey1,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: AppStyles.spaceXS),
                                  Text(
                                    'Supported formats: PDF, DOC, DOCX, JPG, PNG',
                                    style: TextStyle(
                                      color: AppStyles.grey1,
                                      fontSize: 12,
                                    ),
                                  ),
                                ] else ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: AppStyles.welcome,
                                        size: 20,
                                      ),
                                      SizedBox(width: AppStyles.spaceXS),
                                      Expanded(
                                        child: Text(
                                          journalController.filePath.value.split('/').last,
                                          style: TextStyle(
                                            color: AppStyles.dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                SizedBox(height: AppStyles.spaceM),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        try {
                                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
                                            withData: true,
                                          );

                                          if (result != null && result.files.single.path != null) {
                                            journalController.filePath.value = result.files.single.path!;
                                            
                                            Get.snackbar(
                                              'Success',
                                              'File selected successfully',
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor: AppStyles.welcome,
                                              colorText: AppStyles.dark,
                                              duration: Duration(seconds: 2),
                                              margin: EdgeInsets.all(16),
                                            );
                                          }
                                        } catch (e) {
                                          Get.snackbar(
                                            'Error',
                                            'Failed to select file: $e',
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: AppStyles.error,
                                            colorText: AppStyles.light,
                                            duration: Duration(seconds: 3),
                                            margin: EdgeInsets.all(16),
                                          );
                                        }
                                      },
                                      icon: Icon(Icons.attach_file, size: 18),
                                      label: Text(
                                        journalController.filePath.value.isEmpty
                                            ? 'Choose File'
                                            : 'Change File',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppStyles.primary,
                                        foregroundColor: AppStyles.light,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppStyles.paddingL,
                                          vertical: AppStyles.paddingS,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(AppStyles.radius),
                                        ),
                                      ),
                                    ),
                                    if (journalController.filePath.value.isNotEmpty)
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          journalController.filePath.value = '';
                                          Get.snackbar(
                                            'File Removed',
                                            'Selected file has been removed',
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: AppStyles.grey1,
                                            colorText: AppStyles.light,
                                            duration: Duration(seconds: 2),
                                            margin: EdgeInsets.all(16),
                                          );
                                        },
                                        icon: Icon(Icons.delete_outline, size: 18),
                                        label: Text('Remove', style: TextStyle(fontSize: 14)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppStyles.error,
                                          foregroundColor: AppStyles.light,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppStyles.paddingL,
                                            vertical: AppStyles.paddingS,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(AppStyles.radius),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    
                    SizedBox(height: AppStyles.spaceL),
                    SizedBox(height: AppStyles.spaceL),
                    
                    // Submit Button
                    Obx(() => ReuseButton(
                        text: journalController.isLoading.value 
                            ? 'Submitting...' 
                            : 'Submit Journal',
                        onPressed: () async {
                          if (journalController.isLoading.value) {
                            return; // Do nothing if loading
                          }
                          
                          // Validasi input
                          if (selectedTeacherId.value == 0) {
                            Get.snackbar(
                              'Validation Error',
                              'Please select a teacher',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppStyles.error,
                              colorText: AppStyles.light,
                            );
                            return;
                          }
                          
                          if (selectedSubjectId.value == 0) {
                            Get.snackbar(
                              'Validation Error',
                              'Please select a subject',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppStyles.error,
                              colorText: AppStyles.light,
                            );
                            return;
                          }

                          journalController.teacherId.value = selectedTeacherId.value;
                          journalController.subjectId.value = selectedSubjectId.value;

                          await journalController.submitJournal();

                          if (journalController.postSuccess.value) {
                            Navigator.pop(context);
                          }
                        }
                    )),
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