import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_colors_selector_section.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_description_section.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_details_title_section.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_more_details.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_reviews_section.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailsTitleSection(),
              ProductColorsSelectorSection(),
              ProductDescriptionSection(),
              ProductMoreDetails(),
              ProductReviewsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
