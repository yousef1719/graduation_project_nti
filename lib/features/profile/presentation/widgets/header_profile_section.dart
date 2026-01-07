// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class HeaderProfileSection extends StatelessWidget {
  const HeaderProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Center(
          child: Stack(
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.hintTextColor.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.hintTextColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/test/test_profile.jfif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: const Icon(
                    CupertinoIcons.pen,
                    color: AppColors.backgroundColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomText(
          text: 'John Doe',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
        CustomText(
          text: 'john.doe@example.com',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.hintTextColor,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Divider(
                color: AppColors.hintTextColor.withOpacity(0.3),
                thickness: 1,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: '12',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                      CustomText(
                        text: 'Orders',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: '3',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                      CustomText(
                        text: 'Returns',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                        text: '\$450',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      CustomText(
                        text: 'Spent',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(
                color: AppColors.hintTextColor.withOpacity(0.3),
                thickness: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
