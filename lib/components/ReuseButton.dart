import 'package:flutter/material.dart';
import '../../components/AppStyles.dart';

class ReuseButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const ReuseButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppStyles.primaryLight,
    this.textColor = AppStyles.light,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppStyles.padding, vertical: AppStyles.paddingM),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusXL),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(
          text,
          style: AppStyles.welcome2,
        ),
      ),
    );
  }
}