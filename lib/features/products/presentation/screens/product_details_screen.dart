// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_bottom_action_bar.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_header_with_image.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_details_body.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CustomHeaderWithImage(product: product),
          ProductDetailsBody(product: product),
        ],
      ),
      bottomNavigationBar: CustomBottomActionBar(product: product),
    );
  }
}
