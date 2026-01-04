import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/constants/app_images.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text_button.dart';

class CustomBackgroundOnbrdg extends StatelessWidget {
  const CustomBackgroundOnbrdg({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Image.asset(
          AppImages.backgroundOnboarding,
          height: height * 0.55,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: height * 0.04,
          right: width * 0.01,
          child: CustomTextButton(
            text: 'Skip',
            fontSize: 14,
            color: AppColors.backgroundColor,
          ),
        ),
      ],
    );
  }
}
