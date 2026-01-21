import 'package:graduation_project_nti/core/helpers/pref_helper.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/network/api_service.dart';
import 'package:graduation_project_nti/features/auth/data/models/login_model.dart';
import 'package:graduation_project_nti/features/auth/data/models/verification_model.dart';

class AuthRepo {
  final ApiService apiService = ApiService();
  bool isGuest = false;

  /// Login
  Future<LoginModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('auth/login', {
        'email': email,
        'password': password,
      });

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
    } catch (e) {
      rethrow;
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
      final response = await apiService.post('auth/register', {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      });

      if (response is Map<String, dynamic>) {
        // Handle potential explicit success flag if needed, 
        // usually 200/201 is handled by ApiService/Dio
        return true;
      }

      throw ApiError(message: 'Unexpected response from server');
    } catch (e) {
      rethrow;
    }
  }

  /// Verify Email
  Future<VerificationModel> verifyEmail(String email, String otp) async {
    try {
      final response = await apiService.post('auth/verify-email', {
        'email': email,
        'otp': otp,
      });

      if (response is Map<String, dynamic>) {
        return VerificationModel.fromJson(response);
      }

      throw ApiError(message: 'Unexpected response from server');
    } catch (e) {
      rethrow;
    }
  }

  /// Forgot Password
  Future<void> forgotPassword(String email) async {
    try {
      await apiService.post('auth/forgot-password', {
        'email': email,
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  /// Reset Password
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await apiService.post('auth/reset-password', {
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      });
      return;
    } catch (e) {
      rethrow;
    }
  }
}
