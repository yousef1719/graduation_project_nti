import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final loginModel = await authRepo.login(email, password);
      if (loginModel != null) {
        emit(LoginSuccess(loginModel));
      } else {
        emit(LoginError("Invalid response from server"));
      }
    } catch (e) {
      if (e is ApiError) {
        emit(LoginError(e.message));
      } else {
        emit(LoginError("Something went wrong. Please try again."));
      }
    }
  }
}
