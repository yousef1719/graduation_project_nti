import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepo authRepo;

  ResetPasswordCubit(this.authRepo) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());

    try {
      await authRepo.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      emit(ResetPasswordSuccess());
    } catch (e) {
      if (e is ApiError) {
        emit(ResetPasswordError(e.message));
      } else {
        emit(ResetPasswordError("Something went wrong. Please try again."));
      }
    }
  }
}
