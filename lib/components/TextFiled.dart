import 'package:flutter/material.dart';
import 'package:gcc_admin/components/AppStyles.dart';

class MyTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final IconData icon;
  final TextEditingController? controller;

  const MyTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.controller,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller, // Gunakan controller di sini
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.labelText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppStyles.paddingXS, vertical: AppStyles.paddingXS),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal.shade700,
              borderRadius: BorderRadius.circular(AppStyles.radiusS),
            ),
            child: Icon(
              widget.icon,
              color: AppStyles.light,
              size: AppStyles.iconL,
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.teal.shade700,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}