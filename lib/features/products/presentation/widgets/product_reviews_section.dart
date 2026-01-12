// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_rating_widget.dart';

class ProductReviewsSection extends StatelessWidget {
  final ProductModel product;

  const ProductReviewsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Reviews (${product.reviewsCount})',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
            CustomText(
              text: 'See All',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(17),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.hintTextColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.person_circle,
                    color: AppColors.textColor,
                    size: 30,
                  ),
                  SizedBox(width: 6),
                  CustomText(
                    text: 'John Doe',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                  Spacer(),
                  CustomText(
                    text: '2 day ago',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.hintTextColor,
                  ),
                ],
              ),
              SizedBox(height: 6),
              CustomRatingWidget(),
              SizedBox(height: 8),
              CustomText(
                text:
                    'Absolutely love the quality! The leather feels so soft and the stitching is perfect. It fits my phone and wallet perfectly.',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.hintTextColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
