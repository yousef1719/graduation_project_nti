import 'package:dio/dio.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/network/api_exception.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/data/models/review_model.dart';

class ProductRepo {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://accessories-eshop.runasp.net/api',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<ProductModel>> getProducts({
    int page = 1,
    int pageSize = 10,
    String? searchTerm,
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? isInStock,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final response = await dio.get(
        '/products',
        options: Options(
          method: 'GET',
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "page": page,
          "pageSize": pageSize,
          if (searchTerm != null && searchTerm.isNotEmpty) "searchTerm": searchTerm,
          if (category != null) "category": category,
          if (minPrice != null) "minPrice": minPrice,
          if (maxPrice != null) "maxPrice": maxPrice,
          if (isInStock != null) "isInStock": isInStock,
          if (sortBy != null) "sortBy": sortBy,
          if (sortOrder != null) "sortOrder": sortOrder,
        },
      );

      final List itemsRaw = response.data['items'] as List;

      // Deduplicate and filter invalid data
      final Set<String> seenIds = {};
      final List<ProductModel> products = [];

      for (var item in itemsRaw) {
        final product = ProductModel.fromJson(item);
        // Ensure ID is unique and basic fields are present (e.g., name not empty)
        if (product.id.isNotEmpty && !seenIds.contains(product.id) && product.name.isNotEmpty) {
          seenIds.add(product.id);
          products.add(product);
        }
      }

      return products;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<List<ReviewModel>> getProductReviews(
    String productId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await dio.post(
        '/reviews/$productId',
        data: {"productId": productId, "page": page, "pageSize": pageSize},
      );
      final items = response.data['reviews']['items'] as List;
      return items.map((e) => ReviewModel.fromJson(e)).toList();
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await dio.delete('/products/$productId');
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
