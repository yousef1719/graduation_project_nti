import 'package:graduation_project_nti/features/auth/data/models/verification_model.dart';

abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final VerificationModel verificationModel;
  VerificationSuccess(this.verificationModel);
}

class VerificationError extends VerificationState {
  final String message;
  VerificationError(this.message);
}
