import 'package:dio/dio.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/network/api_exception.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';

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
        data: {"page": page, "pageSize": pageSize},
      );

      final items = response.data['items'] as List;
      return items.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

