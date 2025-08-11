import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class CategoriesLine extends StatelessWidget {
  final String image;
  final String title;

  const CategoriesLine({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppStyles.paddingS),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: AppStyles.categoryLineHeight * 0.70,
            decoration: AppStyles.categoryLineDecoration,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: AppStyles.categoryImageSize + AppStyles.paddingXL),
                child: Text(
                  title,
                  style:
                      AppStyles.welcome2.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            top: -AppStyles.categoryLineHeight * 0.5,
            left: AppStyles.paddingXL,
            child: Container(
              width: AppStyles.categoryImageSize,
              height: AppStyles.categoryImageSize,
              padding: EdgeInsets.all(AppStyles.paddingXS),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
