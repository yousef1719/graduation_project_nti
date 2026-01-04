import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      iconAlignment: IconAlignment.end,
      onPressed: () {},
      label: Center(
        child: CustomText(
          text: 'Explore Deels',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
      ),
      icon: Center(
        child: Icon(
          CupertinoIcons.arrow_right,
          color: AppColors.textColor,
          size: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(140, 40),
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
