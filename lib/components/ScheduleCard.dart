import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String subject;
  final String time;
  final String teacher;

  const ScheduleCard({
    super.key,
    required this.day,
    required this.subject,
    required this.time,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 35,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(71, 193, 199, 0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: -1,
                child: Text(
                  day,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 102, 107, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(71, 193, 199, 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 102, 107, 1),
                  ),
                ),
                SizedBox(height: AppStyles.spaceS),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 16, color: Color.fromRGBO(0, 102, 107, 1)),
                    SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 102, 107, 1)),
                    ),
                  ],
                ),
                SizedBox(height: AppStyles.spaceXS),
                Row(
                  children: [
                    Icon(Icons.person,
                        size: 16, color: Color.fromRGBO(0, 102, 107, 1)),
                    SizedBox(width: 4),
                    Text(
                      teacher,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 102, 107, 1)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
