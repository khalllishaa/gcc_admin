import 'package:flutter/material.dart';

class OverlappingAvatars extends StatelessWidget {
  final List<String> imagePaths;
  final double radius;
  final double overlap;

  const OverlappingAvatars({
    super.key,
    required this.imagePaths,
    this.radius = 16,
    this.overlap = 10,
  });

  @override
  Widget build(BuildContext context) {
    final totalWidth = imagePaths.isNotEmpty
        ? ((radius * 2) + (imagePaths.length - 1) * (radius * 2 - overlap))
            .toDouble()
        : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4), // Biar gak ke-cut
      child: SizedBox(
        width: totalWidth,
        height: radius * 2 + 4, // Tambahin tinggi dikit
        child: Stack(
          children: List.generate(imagePaths.length, (index) {
            return Positioned(
              left: index * (radius * 2 - overlap),
              child: CircleAvatar(
                radius: radius,
                backgroundColor: Colors.white, // Biar ada border putih
                child: CircleAvatar(
                  radius: radius - 2,
                  backgroundImage: AssetImage(imagePaths[index]),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
