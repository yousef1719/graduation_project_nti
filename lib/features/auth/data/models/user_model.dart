class UserModel {
  final String? firstName;
  final String? lastName;
  final String email;
  final String? image;
  final String? token;
  final String? refreshToken;
  final String? expiresAtUtc;

  UserModel({
    this.firstName,
    this.lastName,
    required this.email,
    this.image,
    this.token,
    this.refreshToken,
    this.expiresAtUtc,
  });

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      token: json['token'],
    );
  }
}
