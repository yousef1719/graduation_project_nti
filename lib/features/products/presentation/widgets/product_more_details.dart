// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';

class ProductMoreDetails extends StatelessWidget {
  final ProductModel product;

  const ProductMoreDetails({super.key, required this.product});

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
                    text: 'Color',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  subtitle: CustomText(
                    text: product.color,
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
                    text: 'Stock',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  subtitle: CustomText(
                    text: '${product.stock} items',
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
                    text: '${product.weight} kg',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: CustomText(
                    text: 'Code',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                  subtitle: CustomText(
                    text: product.productCode,
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
