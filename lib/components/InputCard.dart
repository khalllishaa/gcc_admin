import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;

  const InputCard({
    super.key,
    required this.label,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(0, 102, 107, 1)),
            borderRadius: BorderRadius.circular(16),
          ),
          width: double.infinity,
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF35AEB1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
