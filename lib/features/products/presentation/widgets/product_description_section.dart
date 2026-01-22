import 'package:flutter/material.dart';
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
          color: Theme.of(context).textTheme.titleLarge?.color,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 10),
        CustomText(
          text: product.description,
          fontSize: 14,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          color: Theme.of(context).textTheme.bodySmall?.color,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 10),
        CustomText(
          text: 'Read more',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
