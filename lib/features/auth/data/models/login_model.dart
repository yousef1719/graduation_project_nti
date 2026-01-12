class LoginModel {
  final String? accessToken;
  final String? refreshToken;
  final String? expiresAtUtc;

  LoginModel({this.accessToken, this.refreshToken, this.expiresAtUtc});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresAtUtc: json['expiresAtUtc'],
    );
  }
}
