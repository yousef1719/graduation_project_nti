import 'package:dio/dio.dart';
import 'package:graduation_project_nti/core/helpers/pref_helper.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/network/api_exception.dart';
import 'package:graduation_project_nti/core/network/api_service.dart';

class ProfileRepo {
  ApiService apiService = ApiService();

  /// Change Password
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    try {
      final token = await PrefHelper.getToken();

      if (token == null || token.isEmpty) {
        throw ApiError(message: 'User not authenticated');
      }

      final response = await apiService.post('/auth/change-password', {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      }, token: token);

      if (response is ApiError) {
        throw response;
      }
      return;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      final token = await PrefHelper.getToken();

      // نرسل POST للـ logout
      await apiService.post('/auth/logout', {}, token: token);

      // نمسح التوكين
      await PrefHelper.clearToken();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
