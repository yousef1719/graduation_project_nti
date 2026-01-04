import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/filter_products_by_category.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_banner_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_category_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_sliver_app_bar_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/popular_header_slivers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          HomeSliverAppBarWidget(),
          SliverToBoxAdapter(child: HomeBannerWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: HomeCategoryWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverToBoxAdapter(child: FilterProductsByCategory()),
          SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverToBoxAdapter(child: PopularHeaderSliver()),
          CustomGridView(),
        ],
      ),
    );
  }
}
