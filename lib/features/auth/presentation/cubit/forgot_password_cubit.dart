
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/services/auth_service.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> sendResetLink(String email) async {
    if (email.isEmpty) {
      emit(ForgotPasswordError("Email is required"));
      return;
    }

    if (!email.contains("@")) {
      emit(ForgotPasswordError("Enter a valid email"));
      return;
    }

    emit(ForgotPasswordLoading());

    try {
      await AuthService.forgotPassword(email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordError("Something went wrong"));
    }
  }
}
