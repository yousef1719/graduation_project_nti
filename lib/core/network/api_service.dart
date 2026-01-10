import 'package:dio/dio.dart';
import 'package:graduation_project_nti/core/network/api_exception.dart';
import 'package:graduation_project_nti/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// CRUD METHODS

  /// GET
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// POST

  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// PUT

  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// DELETE
  Future<dynamic> delete(
    String endpoint,
    Map<String, dynamic> body, {
    dynamic params,
  }) async {
    try {
      final response = await _dioClient.dio.delete(
        endpoint,
        data: body,
        queryParameters: params,
      );
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
}
