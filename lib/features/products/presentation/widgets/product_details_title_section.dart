import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';

class ProductDetailsTitleSection extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsTitleSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomText(
                text: product.name,
                overflow: TextOverflow.visible,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(width: 8),
            CustomText(
              text: '\$${product.price.toStringAsFixed(2)}',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              CupertinoIcons.star,
              color: Theme.of(context).colorScheme.primary,
              size: 14,
            ),
            SizedBox(width: 8),
            CustomText(
              text: product.rating.toStringAsFixed(1),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            SizedBox(width: 6),
            CustomText(
              text: '(${product.reviewsCount} reviews)',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Divider(
          color: Theme.of(context).textTheme.bodySmall?.color,
          thickness: 0.3,
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
