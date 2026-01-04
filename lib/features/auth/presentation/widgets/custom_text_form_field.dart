import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
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
  });

  final String labelText, hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: labelText,
          fontSize: 14,
          color: AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          cursorColor: AppColors.primaryColor,
          keyboardType: keyboardType,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hint: CustomText(
              text: hintText,
              fontSize: 12,
              color: AppColors.hintTextColor,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.hintTextColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
        // SizedBox(height: 5),
      ],
    );
  }
}
