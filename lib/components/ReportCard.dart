import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFB6E9EC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book, color: Colors.teal, size: 30),
              const SizedBox(width: 8),
              Text(
                widget.subject,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Anak memiliki tingkat pemahaman:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
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
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                labelStyle: TextStyle(
                    color: selectedLevel == level ? Colors.white : Colors.black,
                    fontSize: 10),
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
