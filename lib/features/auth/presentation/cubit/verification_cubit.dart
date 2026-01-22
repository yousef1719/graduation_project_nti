import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final AuthRepo authRepo;

  VerificationCubit(this.authRepo) : super(VerificationInitial());

  Future<void> verifyEmail(String email, String otp) async {
    emit(VerificationLoading());

    try {
      final response = await authRepo.verifyEmail(email, otp);
      if (response.success == true) {
        emit(VerificationSuccess(response));
      } else {
        emit(VerificationError(response.message ?? "Verification failed"));
      }
    } catch (e) {
      if (e is ApiError) {
        emit(VerificationError(e.message));
      } else {
        emit(VerificationError("Something went wrong. Please try again."));
      }
    }
  }
}
