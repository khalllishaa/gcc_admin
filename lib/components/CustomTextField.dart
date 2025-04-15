import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class Customtextfield extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;

  const Customtextfield({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
  });

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingS),
      decoration: BoxDecoration(
        color: AppStyles.light,
        border: Border.all(color: AppStyles.primary, width: 1.5),
        borderRadius: BorderRadius.circular(AppStyles.radiusS),
      ),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            style: AppStyles.profileText2,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: AppStyles.grey1),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          Divider(
            color: Colors.black87,
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: AppStyles.spaceM,)
        ],
      ),
    );
  }
}
