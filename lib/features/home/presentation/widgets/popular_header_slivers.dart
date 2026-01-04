import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class PopularHeaderSliver extends StatelessWidget {
  const PopularHeaderSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CustomText(
            text: 'Popular Now',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
          const Spacer(),
          CustomText(
            text: 'Filter',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.hintTextColor,
          ),
          const SizedBox(width: 4),
          Icon(Icons.filter_list, color: AppColors.hintTextColor),
        ],
      ),
    );
  }
}
