import 'package:flutter/material.dart';

class TextFieldes extends StatelessWidget {
  const TextFieldes({
    super.key,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    this.validator,
  });
  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextFormField(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText!,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            label: Text(
              hint,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffCBD5E1),
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
