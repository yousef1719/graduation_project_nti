import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/features/home/data/repo/category_repo.dart';
import 'package:graduation_project_nti/features/home/data/repositories/offer_repository.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_cubit.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_state.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_banner_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_category_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/home_sliver_app_bar_widget.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/popular_header_slivers.dart';
import 'package:graduation_project_nti/features/products/data/repo/product_repo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GlobalKey<HomeSliverAppBarWidgetState> searchBarKey = GlobalKey();

    return BlocProvider(
      create: (context) => HomeCubit(
        categoryRepo: CategoryRepo(),
        productRepo: ProductRepo(),
        offersRepository: OffersRepository(),
      )..fetchHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          bool isSearching = false;
          if (state is HomeLoaded) {
            isSearching = state.isSearching;
          }

          return PopScope(
            canPop: !isSearching,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop && isSearching) {
                searchBarKey.currentState?.closeSearch();
              }
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                searchBarKey.currentState?.closeSearch();
              },
              child: Scaffold(
                backgroundColor: theme.scaffoldBackgroundColor,
                body: _buildBody(context, state, searchBarKey),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    HomeState state,
    GlobalKey<HomeSliverAppBarWidgetState> searchBarKey,
  ) {
    if (state is HomeLoading) {
      return Center(
        child: CupertinoActivityIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    if (state is HomeError) {
      return Center(
        child: Text(
          'Error: ${state.message}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    if (state is HomeLoaded) {
      final theme = Theme.of(context);

      // Filter products
      var products = state.products;

      // 1. Filter by category
      if (state.selectedCategoryId != null) {
        products = products
            .where((p) => p.categories.contains(state.selectedCategoryId))
            .toList();
      }

      // 2. Filter by search query
      if (state.searchQuery.isNotEmpty) {
        final query = state.searchQuery.toLowerCase();
        products = products.where((p) {
          return p.name.toLowerCase().contains(query) ||
              p.description.toLowerCase().contains(query);
        }).toList();
      }

      return CustomScrollView(
        slivers: [
          HomeSliverAppBarWidget(
            key: searchBarKey,
            onSearchChanged: (query) =>
                context.read<HomeCubit>().updateSearchQuery(query),
            onSearchToggled: (isSearching) =>
                context.read<HomeCubit>().toggleSearch(isSearching),
          ),
          if (products.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.search,
                      size: 60,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No products found',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
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
    }

    return const SizedBox.shrink();
  }
}
