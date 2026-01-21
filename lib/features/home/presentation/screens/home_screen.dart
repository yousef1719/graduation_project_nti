import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/utils/debounce.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/custom_grid_view.dart';
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
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  String _currentQuery = '';
  final GlobalKey<HomeSliverAppBarWidgetState> _searchBarKey = GlobalKey();
  bool _isSearchingInternal = false;

  @override
  void initState() {
    super.initState();
    productsFuture = _fetchProducts();
  }

  Future<List<ProductModel>> _fetchProducts({String? searchTerm}) async {
    try {
      return await productRepo.getProducts(
        page: 1,
        pageSize: 50,
        searchTerm: searchTerm,
      );
    } catch (e) {
      rethrow;
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _currentQuery = query;
    });
    _debouncer.run(() {
      setState(() {
        productsFuture = _fetchProducts(searchTerm: query.isNotEmpty ? query : null);
      });
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isSearchingInternal,
      onPopInvoked: (didPop) {
        if (!didPop && _isSearchingInternal) {
          _searchBarKey.currentState?.closeSearch();
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _searchBarKey.currentState?.closeSearch();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: FutureBuilder<List<ProductModel>>(
            future: productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              final rawProducts = snapshot.data ?? [];
              // Client-side substring filtering for partial matches
              final products = (_currentQuery.isNotEmpty)
                  ? rawProducts.where((p) {
                      final query = _currentQuery.toLowerCase();
                      return p.name.toLowerCase().contains(query) ||
                          p.description.toLowerCase().contains(query);
                    }).toList()
                  : rawProducts;

              return CustomScrollView(
                slivers: [
                  HomeSliverAppBarWidget(
                    key: _searchBarKey,
                    onSearchChanged: _onSearchChanged,
                    onSearchToggled: (isSearching) {
                      setState(() {
                        _isSearchingInternal = isSearching;
                      });
                    },
                  ),
                  if (products.isEmpty)
                    const SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No products found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    const SliverToBoxAdapter(child: HomeBannerWidget()),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    const SliverToBoxAdapter(child: HomeCategoryWidget()),
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                    const SliverToBoxAdapter(child: PopularHeaderSliver()),
                    CustomGridView(products: products),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
