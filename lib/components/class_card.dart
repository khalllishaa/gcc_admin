import 'package:flutter/material.dart';
import 'package:gcc_admin/components/OverlappingAvatar.dart';
import 'package:google_fonts/google_fonts.dart';

class KelasCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> avatarImagePaths;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const KelasCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.avatarImagePaths = const [],
    this.backgroundColor = const Color.fromRGBO(71, 193, 199, 0.5),
    this.textColor = const Color.fromRGBO(0, 102, 107, 1),
    this.iconColor = const Color(0xFF004D40),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310, // Atur lebar manual di sini
      height: 130, // Atur tinggi manual di sini
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 150,
            height: 150,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 2),
                OverlappingAvatars(
                  imagePaths: avatarImagePaths,
                  radius: 14,
                  overlap: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
