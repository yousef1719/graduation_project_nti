import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

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
    this.validator,
    this.hight,
  });

  final String labelText, hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? hight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: labelText,
          fontSize: 14,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          cursorColor: Theme.of(context).colorScheme.primary,
          keyboardType: keyboardType,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
            border: Theme.of(context).inputDecorationTheme.border,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          ),
        ),
        // SizedBox(height: 5),
      ],
    );
  }
}
