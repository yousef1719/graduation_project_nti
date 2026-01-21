import 'package:graduation_project_nti/core/network/api_service.dart';
import 'package:graduation_project_nti/features/home/data/models/category_model.dart';

class CategoryRepo {
  final ApiService _apiService = ApiService();

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiService.get('categories');

      if (response is List) {
        return response.map((e) => CategoryModel.fromJson(e)).toList();
      } else if (response is Map<String, dynamic>) {
        // Fallback for different API response structures
        final List? categoryList =
            response['data'] ??
            response['categories'] ??
            response['result'] ??
            response['values'];

        if (categoryList != null) {
          return categoryList.map((e) => CategoryModel.fromJson(e)).toList();
        }

        // Deep search for first list if keys don't match
        final firstList = response.values.firstWhere(
          (value) => value is List,
          orElse: () => null,
        );

        if (firstList != null) {
          return (firstList as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
        }
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
