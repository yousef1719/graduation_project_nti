import 'package:dio/dio.dart';

class AuthService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://accessories-eshop.runasp.net',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<void> forgotPassword(String email) async {
    await _dio.post(
      '/api/auth/forgot-password',
      data: {
        "email": email,
      },
    );
  }
}
