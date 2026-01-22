import 'package:dio/dio.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // ✅ لو السيرفر رجع validation errors
    if (data is Map<String, dynamic>) {
      // 1. Check for 'errors' map (Validation errors) - PRIORITIZE THIS for detail
      if (data['errors'] != null && data['errors'] is Map<String, dynamic>) {
        final errorsMap = data['errors'] as Map<String, dynamic>;

        final allErrors = errorsMap.values
            .expand((e) => e is List ? e : [e.toString()])
            .join('\n');

        if (allErrors.isNotEmpty) {
          return ApiError(message: allErrors, statusCode: statusCode);
        }
      }

      // 2. Fallback to 'message' field (General error)
      if (data['message'] != null && data['message'].toString().isNotEmpty) {
        return ApiError(
          message: data['message'].toString(),
          statusCode: statusCode,
        );
      }
    } else if (data != null && data.toString().isNotEmpty) {
      // ✅ Handle string-based errors (like the one in the screenshot)
      return ApiError(message: data.toString(), statusCode: statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: 'Connection timeout with server',
          statusCode: statusCode,
        );
      case DioExceptionType.sendTimeout:
        return ApiError(
          message: 'Send timeout, please try again',
          statusCode: statusCode,
        );
      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: 'Response timeout from server',
          statusCode: statusCode,
        );
      case DioExceptionType.badResponse:
        if (statusCode == 401) {
          return ApiError(
            message: 'Unauthorized access. Please login.',
            statusCode: statusCode,
          );
        }
        if (statusCode == 404) {
          return ApiError(
            message: 'Resource not found (404)',
            statusCode: statusCode,
          );
        }
        if (statusCode == 400) {
          return ApiError(message: 'Bad request (400)', statusCode: statusCode);
        }
        if (statusCode == 500) {
          return ApiError(
            message: 'Server error (500)',
            statusCode: statusCode,
          );
        }
        return ApiError(
          message: 'API error: ${statusCode ?? "unknown"}',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return ApiError(message: 'Request cancelled', statusCode: statusCode);
      case DioExceptionType.connectionError:
        return ApiError(
          message: 'No internet connection',
          statusCode: statusCode,
        );
      default:
        return ApiError(
          message: 'Something went wrong. Please try again.',
          statusCode: statusCode,
        );
    }
  }
}
