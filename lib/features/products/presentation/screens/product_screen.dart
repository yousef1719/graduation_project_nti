// ignore_for_file: deprecated_member_use

import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/data/repo/product_repo.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_floating_add_button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductRepo productRepo = ProductRepo();
  late Future<List<ProductModel>> productsFuture;
  int currentPage = 1;
  int pageSize = 10;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    productsFuture = _fetchProducts();
  }

  Future<List<ProductModel>> _fetchProducts() async {
    try {
      return await productRepo.getProducts(
        page: currentPage,
        pageSize: pageSize,
      );
    } catch (e) {
      rethrow;
    }
  }

  void _refreshProducts() {
    setState(() {
      productsFuture = _fetchProducts();
    });
  }

  Future<void> _handleRefresh() async {
    _refreshProducts();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidget: CustomFloatingAddButton(),
      floatingWidgetHeight: 40,
      floatingWidgetWidth: 40,
      dx: MediaQuery.of(context).size.width - 28,
      dy: MediaQuery.of(context).size.height - 288,
      mainScreenWidget: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: 'Products',
            centerTitle: true,
            leading: const SizedBox.shrink(),
          ),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: _handleRefresh,
              builder:
                  (
                    BuildContext context,
                    RefreshIndicatorMode refreshState,
                    double pulledExtent,
                    double refreshTriggerPullDistance,
                    double refreshIndicatorExtent,
                  ) {
                    return CupertinoActivityIndicator(
                      radius: 10,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  },
            ),
            FutureBuilder<List<ProductModel>>(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: 10,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.exclamationmark_circle,
                            size: 50,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading products',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.error.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 20),
                          CupertinoButton(
                            onPressed: _refreshProducts,
                            color: Theme.of(context).colorScheme.primary,
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.cube_box,
                            size: 60,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No products found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            text: 'Add new products to see them here',
                            fontSize: 14,
                            color:
                                Theme.of(context).textTheme.bodySmall?.color ??
                                Colors.grey,
                          ),
                          const SizedBox(height: 20),
                          CupertinoButton(
                            onPressed: _refreshProducts,
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return CustomGridView(products: snapshot.data!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
