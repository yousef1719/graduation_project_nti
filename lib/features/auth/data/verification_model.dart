class VerificationModel {
  final String? message;
  final bool? success;

  VerificationModel({this.message, this.success});

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      message: json['message'],
      success: json['success'] ?? false,
    );
  }
}
