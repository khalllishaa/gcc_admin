import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.paddingS),
      child: Text(
        title,
        style: AppStyles.welcome2.copyWith(
          color: AppStyles.dark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
