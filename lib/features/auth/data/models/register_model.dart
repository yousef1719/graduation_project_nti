class RegisterModel {
  final String? message;

  RegisterModel({this.message});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(message: json['message']);
  }
}
