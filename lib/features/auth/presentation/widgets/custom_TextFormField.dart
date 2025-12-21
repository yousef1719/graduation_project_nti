import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
  });

  final String labelText, hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Color(0XFF171717),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          cursorColor: Color(0xff9A594C),
          keyboardType: keyboardType,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hint: Text(hintText, style: TextStyle(color: Color(0xff9A594C))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffE2E2E2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xff9A594C), width: 1),
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
