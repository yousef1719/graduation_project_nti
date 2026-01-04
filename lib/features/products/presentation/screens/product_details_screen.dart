// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_bottom_action_bar.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_header_with_image.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/product_details_body.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [CustomHeaderWithImage(), ProductDetailsBody()],
      ),
      bottomNavigationBar: CustomBottomActionBar(),
    );
  }
}
