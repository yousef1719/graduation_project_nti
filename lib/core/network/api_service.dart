import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project_nti/core/network/api_exception.dart';
import 'package:graduation_project_nti/core/network/dio_client.dart';
import 'dart:convert';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// CRUD METHODS

  /// GET
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        endpoint,
        queryParameters: queryParams,
        data: {}, // Add empty body to satisfy server
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType
              .plain, // Get as plain text to handle non-JSON responses
        ),
      );

      // Try to parse as JSON
      try {
        return jsonDecode(response.data);
      } catch (e) {
        // If not JSON, return the raw data
        return response.data;
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  /// POST

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        endpoint,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  /// PUT

  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
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
      throw ApiExceptions.handleError(e);
    }
  }
}
