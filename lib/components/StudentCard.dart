import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onMore;

  const StudentCard({
    Key? key,
    required this.name,
    required this.onEdit,
    required this.onDelete,
    required this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color.fromRGBO(0, 102, 107, 1), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.cyan.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(0, 102, 107, 1),
              child: Icon(Icons.person_outline, color: Colors.white),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // More button
            InkWell(
              onTap: onMore,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.more_horiz, size: 15),
              ),
            ),
            // Edit button
            InkWell(
              onTap: onEdit,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.edit_outlined, size: 15),
              ),
            ),
            // Delete button
            InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.delete_outline, size: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
