import 'package:flutter/material.dart';

import 'AppStyles.dart';

// Enum to define box style options
enum ProfileItemBoxStyle { shadow, border }

class ProfileItem extends StatelessWidget {
  final String textPrimary;
  final String textSecond;
  final ProfileItemBoxStyle boxStyle;

  const ProfileItem({
    Key? key,
    required this.textPrimary,
    required this.textSecond,
    this.boxStyle = ProfileItemBoxStyle.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = boxStyle == ProfileItemBoxStyle.shadow
        ? BoxDecoration(
      color: AppStyles.grey2,
      borderRadius: BorderRadius.circular(AppStyles.radiusXL),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 0,
          offset: Offset(2, 4),
        ),
      ],
    )
        : BoxDecoration(
      color: AppStyles.secondaryLight,
      border: Border.all(
        color: AppStyles.primary,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(AppStyles.radiusM),
    );

    return Container(
      decoration: boxDecoration,
      width: double.infinity,
      padding: EdgeInsets.all(AppStyles.paddingL),
      margin: EdgeInsets.only(bottom: AppStyles.paddingL),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textPrimary,
                  style: AppStyles.profileText1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppStyles.spaceXS),
                Text(
                  textSecond,
                  style: AppStyles.profileText2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}