import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:gcc_admin/components/JournalCard.dart';
import 'package:get/get.dart';

class ListReport extends StatelessWidget {
  const ListReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
          child: Row(
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL),
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppStyles.primaryDark,
                    borderRadius: BorderRadius.circular(AppStyles.radiusL),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today, color: AppStyles.light, size: AppStyles.iconL),
                      SizedBox(width: AppStyles.spaceS),
                      Text(
                        "13 Januari",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingFont),
          child: Column(
            children: [
              SizedBox(height: AppStyles.spaceL),
              GestureDetector(
                onTap: () => Get.toNamed('/view-report'),
                child: CourseCard(
                  title: "Report",
                  subtitle: "Murid 1",
                  imagePath: "images/student.png",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-report'),
        backgroundColor: AppStyles.dark,
        shape: CircleBorder(),
        child: Icon(Icons.add, color:AppStyles.primaryLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
