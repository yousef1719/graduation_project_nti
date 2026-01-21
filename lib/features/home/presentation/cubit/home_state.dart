import 'package:graduation_project_nti/features/home/data/models/category_model.dart';
import 'package:graduation_project_nti/features/home/data/models/offer_banner_model.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final List<OfferBannerModel> banners;
  final String? selectedCategoryId;
  final String searchQuery;
  final bool isSearching;

  HomeLoaded({
    required this.categories,
    required this.products,
    required this.banners,
    this.selectedCategoryId,
    this.searchQuery = '',
    this.isSearching = false,
  });

  HomeLoaded copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    List<OfferBannerModel>? banners,
    String? selectedCategoryId,
    String? searchQuery,
    bool? isSearching,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      banners: banners ?? this.banners,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
