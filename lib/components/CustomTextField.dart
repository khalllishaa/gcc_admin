import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class Customtextfield extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final void Function(String)? onChanged;

  const Customtextfield({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingS),
      decoration: BoxDecoration(
        color: AppStyles.light,
        border: Border.all(color: AppStyles.primary, width: 1.5),
        borderRadius: BorderRadius.circular(AppStyles.radiusL),
      ),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            style: AppStyles.profileText2,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: AppStyles.grey1),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: AppStyles.paddingL),
              suffixIcon: widget.obscureText ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppStyles.grey1,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ) : null,
            ),
          ),
          Divider(
            color: AppStyles.dark,
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: AppStyles.spaceM),
        ],
      ),
    );
  }
}