import 'package:dio/dio.dart';
import 'package:graduation_project_nti/core/helpers/pref_helper.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/network/api_exception.dart';
import 'package:graduation_project_nti/core/network/api_service.dart';
import 'package:graduation_project_nti/features/auth/data/login_model.dart';
import 'package:graduation_project_nti/features/auth/data/verification_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;

  /// Login
  Future<LoginModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final loginData = LoginModel.fromJson(response);
        if (loginData.accessToken == null || loginData.accessToken!.isEmpty) {
          throw ApiError(message: 'Invalid login response');
        }
        await PrefHelper.saveToken(loginData.accessToken!);
        isGuest = false;
        return loginData;
      }
      throw ApiError(message: 'Unexpected response from server');
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Signup
  Future<bool> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final response = await apiService.post('/auth/register', {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        if (response['errors'] != null) {
          final errorMsg = response['errors'].values
              .map((list) => (list as List).join(', '))
              .join('\n');
          throw ApiError(
            message: errorMsg.isNotEmpty
                ? errorMsg
                : response['message'] ?? 'Register failed',
          );
        }
        return true;
      }

      throw ApiError(message: 'Unexpected response from server');
    } catch (e) {
      rethrow;
    }
  }

  /// verify email
  Future<VerificationModel> verifyEmail(String email, String otp) async {
    try {
      final response = await apiService.post('/auth/verify-email', {
        'email': email,
        'otp': otp,
      });

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        return VerificationModel.fromJson(response);
      }

      throw ApiError(message: 'Unexpected response from server');
    } catch (e) {
      rethrow;
    }
  }
}
