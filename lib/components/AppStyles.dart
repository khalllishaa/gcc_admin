import 'package:flutter/material.dart';

class AppStyles {
  // Color Apps
  static const Color light = Color(0xFFF5F5F5);
  static const Color dark = Color(0xFF191919);
  static const Color grey1 = Color(0xFF606060);
  static const Color grey2 = Color(0xFFE8E8E8);
  static const Color primary = Color(0xFF00666B);
  static const Color primaryLight = Color(0xFF40B2B7);
  static const Color primaryDark = Color(0xFF00979F);
  static const Color secondary = Color(0xFF37ABB1);
  static const Color schedule = Color(0xFFFF9F4B);
  static const Color login = Color(0xFFFFF8E8);
  static const Color secondaryLight = Color(0xFFA2DFE2);
  static const Color welcome = Color(0xFFA2DFE2);
  static const Color error = Color(0xFFFF001F);
  static Color shadowColor = Colors.grey.withOpacity(0.1);

  // Text Style
  static const TextStyle headingStyle = TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppStyles.light);
  static const TextStyle splashscreen = TextStyle(fontSize: 20, fontFamily: 'Times New Roman', fontWeight: FontWeight.bold, color: AppStyles.light);
  static const TextStyle heading1 = TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppStyles.dark);
  static const TextStyle heading2 = TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: AppStyles.grey1);
  static const TextStyle welcome1 = TextStyle(fontSize: 30, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppStyles.light);
  static const TextStyle welcome2 = TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: AppStyles.light);
  static const TextStyle lesson = TextStyle(fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: AppStyles.light);
  static const TextStyle profileText1 = TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppStyles.dark);
  static const TextStyle profileText2 = TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: AppStyles.dark);

  //Box Decoration
  static BoxDecoration categoryLineDecoration = BoxDecoration(color: AppStyles.primaryDark, borderRadius: BorderRadius.circular(AppStyles.radiusS),);

  // Image & widget
  static const double logo = 200.0;
  static const double logoHeading = 55.0;
  static const double profile = 70.0;
  static const double categoryLineHeight = 64.0;
  static const double categoryLineHeightt = 90.0;
  static const double categoryImageSize = 80.0;
  static const double cardWidth = 280.0;
  static const double detailIconSize = 45.0;
  static const double IconSize = 90.0;
  static const double bottomNavHeight = 90.0;
  static const double classCardHeight = 126.0;
  static const double detailHeaderHeight = 100.0;
  static const double detailHeaderRadius = 50.0;
  static const double teacherHeight = 100.0;
  static const double classCard = 310.0;
  static const double classCard2 = 130.0;

  // Icon Sizes
  static const double iconS = 15.0;
  static const double iconM = 17.0;
  static const double iconL = 20.0;
  static const double iconXL = 30.0;
  static const double avatarIconSize = 30.0;
  static const double classImageSize = 104.0;

  // Padding & Margin
  static const double paddingXXS = 2.0;
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 12.0;
  static const double paddingL = 15.0;
  static const double paddingXL = 20.0;
  static const double padding = 24.0;
  static const double paddingFont = 30.0;
  static const double paddingXXL = 100.0;

  // Spacing
  static const double spaceXXS = 2.0;
  static const double spaceXS = 5.0;
  static const double spaceS = 10.0;
  static const double spaceM = 15.0;
  static const double spaceL = 20.0;
  static const double space = 28.0;
  static const double spaceXL = 45.0;
  static const double spaceXXL = 60.0;

  // Border Radius
  static const double radiusS = 10.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiussXL = 30.0;
  static const double radius = 40.0;
  static const double radiusXXL = 50.0;

}
