// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class ProductMoreDetails extends StatelessWidget {
  const ProductMoreDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.hintTextColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: CustomText(
                    text: 'Material',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  subtitle: CustomText(
                    text: 'Genuine Leather',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: CustomText(
                    text: 'Style',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  subtitle: CustomText(
                    text: 'Casual / Chic',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: CustomText(
                    text: 'Weight',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  subtitle: CustomText(
                    text: '0.45 kg',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: CustomText(
                    text: 'Warranty',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  subtitle: CustomText(
                    text: '2 years',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
