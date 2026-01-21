import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit(this.authRepo) : super(RegisterInitial());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      final success = await authRepo.signup(firstName, lastName, email, password);
      if (success) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterError("Signup failed"));
      }
    } catch (e) {
      if (e is ApiError) {
        emit(RegisterError(e.message));
      } else {
        emit(RegisterError("Something went wrong. Please try again."));
      }
    }
  }
}
