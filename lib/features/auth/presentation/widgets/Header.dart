// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 25,
          color: AppColors.textColor,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 10),
        CustomText(
          text: subtitle,
          fontSize: 14,
          color: AppColors.hintTextColor,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
