import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/splash/presentation/widgets/custom_indicator_widget.dart';

class CustomBodyOnboarding extends StatelessWidget {
  const CustomBodyOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomText(
            text: 'Discover Unique',
            fontSize: 28,
            color: AppColors.textColor,
            fontWeight: FontWeight.w800,
          ),
          CustomText(
            text: 'Accessories',
            fontSize: 28,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w800,
          ),
          const SizedBox(height: 15),
          CustomText(
            text:
                'Shop the latest trends in jewelry, watches,\nand bags tailored just for you.',
            fontSize: 14,
            textAlign: TextAlign.center,
            color: AppColors.hintTextColor,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 20),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return CustomIndicatorWidget(value: value);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffEC3713),
              minimumSize: Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
            ),
            onPressed: () {},
            child: CustomText(
              text: 'Get Started',
              fontSize: 16,
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
