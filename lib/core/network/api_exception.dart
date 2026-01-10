import 'package:dio/dio.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // ✅ لو السيرفر رجع validation errors
    if (data is Map<String, dynamic>) {
      // email error
      if (data['errors'] != null && data['errors'] is Map<String, dynamic>) {
        final errorsMap = data['errors'] as Map<String, dynamic>;

        if (errorsMap['email'] != null &&
            errorsMap['email'] is List &&
            errorsMap['email'].isNotEmpty) {
          return ApiError(
            message: errorsMap['email'][0],
            statusCode: statusCode,
          );
        }

        // أي error تاني
        final firstError = errorsMap.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return ApiError(message: firstError[0], statusCode: statusCode);
        }
      }

      // fallback message
      if (data['message'] != null) {
        return ApiError(message: data['message'], statusCode: statusCode);
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Send timeout, Please try again');
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Response timeout, Please try again');
      default:
        return ApiError(
          message: 'An unexpected error occurred. Please try again.',
        );
    }
  }
}
