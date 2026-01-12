import 'package:flutter/cupertino.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';

class ProductDescriptionSection extends StatelessWidget {
  final ProductModel product;

  const ProductDescriptionSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        CustomText(
          text: 'Description',
          fontSize: 18,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 10),
        CustomText(
          text: product.description,
          fontSize: 14,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          color: AppColors.hintTextColor,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 10),
        CustomText(
          text: 'Read more',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
