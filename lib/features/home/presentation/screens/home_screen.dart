import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/filter_products_by_category.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_banner_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_category_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_sliver_app_bar_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/popular_header_slivers.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/data/repo/product_repo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductRepo productRepo = ProductRepo();
  late Future<List<ProductModel>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = _fetchProducts();
  }

  Future<List<ProductModel>> _fetchProducts() async {
    try {
      return await productRepo.getProducts(page: 1, pageSize: 10);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<List<ProductModel>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              HomeSliverAppBarWidget(),
              SliverToBoxAdapter(child: HomeBannerWidget()),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(child: HomeCategoryWidget()),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(child: FilterProductsByCategory()),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(child: PopularHeaderSliver()),
              CustomGridView(products: products),
            ],
          );
        },
      ),
    );
  }
}
