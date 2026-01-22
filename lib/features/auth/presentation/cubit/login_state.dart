import 'package:graduation_project_nti/features/auth/data/models/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
