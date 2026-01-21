import 'package:graduation_project_nti/core/network/api_service.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/data/models/review_model.dart';

class ProductRepo {
  final ApiService _apiService = ApiService();

  Future<List<ProductModel>> getProducts({
    int page = 1,
    int pageSize = 50,
    String? searchTerm,
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? isInStock,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final response = await _apiService.get(
        'products',
        queryParams: {
          "page": page,
          "pageSize": pageSize,
          if (searchTerm != null && searchTerm.isNotEmpty)
            "searchTerm": searchTerm,
          if (category != null) "category": category,
          if (minPrice != null) "minPrice": minPrice,
          if (maxPrice != null) "maxPrice": maxPrice,
          if (isInStock != null) "isInStock": isInStock,
          if (sortBy != null) "sortBy": sortBy,
          if (sortOrder != null) "sortOrder": sortOrder,
        },
      );

      if (response is! Map<String, dynamic> || response['items'] == null) {
        return [];
      }

      final List itemsRaw = response['items'] as List;

      // Deduplicate and filter invalid data
      final Set<String> seenIds = {};
      final List<ProductModel> products = [];

      for (var item in itemsRaw) {
        final product = ProductModel.fromJson(item);
        if (product.id.isNotEmpty &&
            !seenIds.contains(product.id) &&
            product.name.isNotEmpty) {
          seenIds.add(product.id);
          products.add(product);
        }
      }

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _apiService.post('products', productData);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReviewModel>> getProductReviews(
    String productId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _apiService.post('reviews/$productId', {
        "productId": productId,
        "page": page,
        "pageSize": pageSize,
      });
      if (response is! Map<String, dynamic> || response['reviews'] == null) {
        return [];
      }
      final items = response['reviews']['items'] as List;
      return items.map((e) => ReviewModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _apiService.delete('products/$productId', {});
    } catch (e) {
      rethrow;
    }
  }
}
