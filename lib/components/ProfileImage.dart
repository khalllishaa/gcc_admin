import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';
import 'package:iconly/iconly.dart';

class ProfileImagePicker extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onPickFromCamera;
  final VoidCallback onPickFromGallery;

  const ProfileImagePicker({
    Key? key,
    required this.image,
    required this.onPickFromCamera,
    required this.onPickFromGallery,
  }) : super(key: key);

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
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
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
      height: 280,
      decoration: BoxDecoration(
        color: AppStyles.light,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.radiusXL)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: AppStyles.paddingM, bottom: AppStyles.paddingXL),
            child: Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: AppStyles.dark,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: AppStyles.spaceM),
          Text(
            "Pilih Sumber Foto",
            style: AppStyles.heading1,
          ),
          SizedBox(height: AppStyles.spaceXL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(
                icon: IconlyBold.camera,
                label: "Kamera",
                onTap: () {
                  Navigator.pop(context);
                  onPickFromCamera();
                },
              ),
              _buildOption(
                icon: IconlyBold.folder,
                label: "Galeri",
                onTap: () {
                  Navigator.pop(context);
                  onPickFromGallery();
                },
              ),
            ],
          )
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
          Icon(icon, size: 60, color: AppStyles.dark),
          SizedBox(height: AppStyles.spaceS),
          Text(label, style: TextStyle(fontSize: 14, color: AppStyles.dark)),
        ],
      ),
    );
  }
}
