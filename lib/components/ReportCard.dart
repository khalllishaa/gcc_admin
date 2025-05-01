import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class AssessmentCard extends StatefulWidget {
  final String subject;

  const AssessmentCard({super.key, required this.subject});

  @override
  State<AssessmentCard> createState() => _AssessmentCardState();
}

class _AssessmentCardState extends State<AssessmentCard> {
  String selectedLevel = '';

  final List<String> levels = ['Perlu Ditingkatkan', 'Baik', 'Sangat Baik'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppStyles.paddingM),
      padding: EdgeInsets.all(AppStyles.paddingL),
      decoration: BoxDecoration(
        color:AppStyles.secondaryLight,
        borderRadius: BorderRadius.circular(AppStyles.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_book, color: AppStyles.primaryDark, size: 30),
              SizedBox(width: AppStyles.spaceS),
              Text(
                widget.subject,
                style: AppStyles.welcome2.copyWith(color: AppStyles.dark, fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
          SizedBox(height: AppStyles.spaceS),
          Text(
            'Anak memiliki tingkat pemahaman:',
            style: AppStyles.profileText1.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: AppStyles.spaceS),
          Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: levels.map((level) {
              return ChoiceChip(
                label: Text(level),
                selected: selectedLevel == level,
                onSelected: (bool selected) {
                  setState(() {
                    selectedLevel = selected ? level : '';
                  });
                },
                selectedColor: Colors.teal,
                backgroundColor: Colors.white,
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                labelStyle: TextStyle(
                    color: selectedLevel == level ? AppStyles.light : Colors.black,
                    fontSize: 10,
                    fontFamily: 'Poppins'),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.black.withOpacity(0.2)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
