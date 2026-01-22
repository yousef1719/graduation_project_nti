import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_colors_selector_section.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_description_section.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_details_title_section.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_more_details.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_reviews_section.dart';

class ProductDetailsBody extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsBody({super.key, required this.product});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailsTitleSection(product: widget.product),
              ProductColorsSelectorSection(),
              ProductDescriptionSection(product: widget.product),
              ProductMoreDetails(product: widget.product),
              ProductReviewsSection(product: widget.product),
            ],
          ),
        ),
      ),
    );
  }
}
