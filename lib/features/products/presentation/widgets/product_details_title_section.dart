import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class ProductDetailsTitleSection extends StatelessWidget {
  const ProductDetailsTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Leather Crossbody\nBag',
              overflow: TextOverflow.visible,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
            const Spacer(),
            CustomText(
              text: '\$120.00',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(CupertinoIcons.star, color: AppColors.primaryColor, size: 14),
            SizedBox(width: 8),
            CustomText(
              text: '4.8',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
            SizedBox(width: 6),
            CustomText(
              text: '(120 reviews)',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.hintTextColor,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Divider(color: AppColors.hintTextColor, thickness: 0.3),
        const SizedBox(height: 14),
      ],
    );
  }
}
