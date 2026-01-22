import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/core/utils/debounce.dart';
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

  final ScrollController _scrollController = ScrollController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  // Search and Selection state
  String _currentSearchTerm = '';
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSelectionMode = false;
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    productsFuture = _fetchProducts();
  }

  Future<List<ProductModel>> _fetchProducts({String? searchTerm}) async {
    try {
      return await productRepo.getProducts(
        page: currentPage,
        pageSize: 50,
        searchTerm: searchTerm,
      );
    } catch (e) {
      rethrow;
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _currentSearchTerm = query;
    });
    _debouncer.run(() {
      setState(() {
        productsFuture = _fetchProducts(
          searchTerm: query.isNotEmpty ? query : null,
        );
      });
    });
  }

  void _toggleSelection(String productId) {
    setState(() {
      _isSelectionMode = true;
      if (_selectedIds.contains(productId)) {
        _selectedIds.remove(productId);
        if (_selectedIds.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedIds.add(productId);
      }
    });
  }

  Future<void> _deleteSelectedProducts() async {
    final confirmed = await _showConfirmDeleteDialog(_selectedIds.toList());
    if (confirmed) {
      try {
        for (var id in _selectedIds) {
          await productRepo.deleteProduct(id);
        }
        setState(() {
          _selectedIds.clear();
          _isSelectionMode = false;
        });
        _refreshProducts();
      } catch (e) {
        _showErrorSnackBar('Failed to delete some products: $e');
      }
    }
  }

  void _refreshProducts() {
    setState(() {
      productsFuture = _fetchProducts(searchTerm: _currentSearchTerm);
    });
  }

  Future<bool> _showConfirmDeleteDialog(List<String> ids) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Delete Product'),
            content: Text(
              'Are you sure you want to delete ${ids.length == 1 ? 'this product' : '${ids.length} products'}? This action cannot be undone.',
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _handleRefresh() async {
    _refreshProducts();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidget: CustomFloatingAddButton(),
      floatingWidgetHeight: 40,
      floatingWidgetWidth: 40,
      dx: MediaQuery.of(context).size.width - 28,
      dy: MediaQuery.of(context).size.height - 288,
      mainScreenWidget: PopScope(
        canPop: !_isSelectionMode,
        onPopInvoked: (didPop) {
          if (!didPop && _isSelectionMode) {
            setState(() {
              _isSelectionMode = false;
              _selectedIds.clear();
            });
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                title: _isSelectionMode
                    ? '${_selectedIds.length} Selected'
                    : 'Products',
                centerTitle: true,
                leading: _isSelectionMode
                    ? IconButton(
                        icon: const Icon(CupertinoIcons.xmark),
                        onPressed: () {
                          setState(() {
                            _isSelectionMode = false;
                            _selectedIds.clear();
                          });
                        },
                      )
                    : const SizedBox.shrink(),
                showSearch: !_isSelectionMode,
                onSearchChanged: _onSearchChanged,
                onSearchToggled: (isSearching) {
                  if (!isSearching) {
                    _onSearchChanged('');
                  }
                },
                actions: [
                  if (_isSelectionMode)
                    IconButton(
                      icon: const Icon(CupertinoIcons.trash, color: Colors.red),
                      onPressed: _deleteSelectedProducts,
                    )
                  else
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isSelectionMode = true;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.checkmark_circle,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      tooltip: 'Select Products',
                    ),
                ],
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
                    }

                    final rawProducts = snapshot.data ?? [];
                    // Hybrid Search: API results + Local substring filtering for true partial matches
                    final products = (_currentSearchTerm.isNotEmpty)
                        ? rawProducts.where((p) {
                            final query = _currentSearchTerm.toLowerCase();
                            return p.name.toLowerCase().contains(query) ||
                                p.description.toLowerCase().contains(query);
                          }).toList()
                        : rawProducts;

                    if (products.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.cube_box,
                                size: 60,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
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
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color ??
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
                      return CustomGridView(
                        products: products,
                        isSelectionMode: _isSelectionMode,
                        selectedIds: _selectedIds,
                        onSelectionChanged: _toggleSelection,
                        // Don't pass onDeletePressed - we only delete via selection mode
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
