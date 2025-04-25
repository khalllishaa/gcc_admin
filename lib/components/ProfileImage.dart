import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class ProfileImagePicker extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onPickFromCamera;
  final VoidCallback onPickFromGallery;

  const ProfileImagePicker({
    required this.image,
    required this.onPickFromCamera,
    required this.onPickFromGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: image,
          radius: 65,
          backgroundColor: AppStyles.light,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppStyles.light,
                builder: (_) => _buildBottomSheet(context),
              );
            },
            child: CircleAvatar(
              radius: AppStyles.radiusXL,
              backgroundColor: AppStyles.primaryDark,
              child: Icon(Icons.camera_alt, color: AppStyles.light, size: AppStyles.iconL),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppStyles.spaceL),
      height: 280,
      decoration: BoxDecoration(
        color: AppStyles.light,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.radiusXL)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: AppStyles.light,
              borderRadius: BorderRadius.circular(AppStyles.radiusS),
            ),
          ),
          SizedBox(height: AppStyles.spaceL),
          Text(
            "Pilih Sumber Foto",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppStyles.dark,
            ),
          ),
          SizedBox(height: AppStyles.spaceXL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(icon: Icons.camera_alt, label: "Kamera", onTap: () {
                Navigator.pop(context);
                onPickFromCamera();
              }),
              _buildOption(icon: Icons.photo_library, label: "Galeri", onTap: () {
                Navigator.pop(context);
                onPickFromGallery();
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}

// class ProfileImagePickerModel {
//   final ImageProvider image;
//   final double avatarRadius;
//   final double cameraRadius;
//   final Color cameraBackgroundColor;
//   final Icon cameraIcon;
//   final VoidCallback onCameraTap;
//
//   ProfileImagePickerModel({
//     required this.image,
//     required this.avatarRadius,
//     required this.cameraRadius,
//     required this.cameraBackgroundColor,
//     required this.cameraIcon,
//     required this.onCameraTap,
//   });
// }

