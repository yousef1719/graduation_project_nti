import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/header.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/login_screen.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key, this.email, this.otp});
  final String? email;
  final String? otp;

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ResetPasswordCubit(AuthRepo()),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: 'Password reset successfully 🎉',
                backgroundColor: Colors.green.shade700,
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          }
          if (state is ResetPasswordError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: state.message,
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ResetPasswordLoading;

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                onPressedLeading: () => Navigator.pop(context),
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Header(
                            title: 'Create new password',
                            subtitle:
                                'Your new password must be unique from those previously used.',
                          ),
                          const SizedBox(height: 32),
                          CustomTextField(
                            labelText: "Password",
                            hintText: "Create a password",
                            obscureText: !isVisible,
                            validator: (pass) =>
                                Validator.validatePassword(pass!),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              color: isVisible
                                  ? theme.colorScheme.primary
                                  : theme.textTheme.bodySmall?.color,
                              iconSize: 20,
                            ),
                            controller: newPasswordController,
                          ),
                          const SizedBox(height: 18),
                          CustomTextField(
                            labelText: 'Confirm Password',
                            hintText: 'Re-enter your new password',
                            obscureText: !isVisible,
                            validator: (pass) {
                              if (pass != newPasswordController.text) {
                                return "Passwords don't match";
                              }
                              return Validator.validatePassword(pass!);
                            },
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              color: isVisible
                                  ? theme.colorScheme.primary
                                  : theme.textTheme.bodySmall?.color,
                              iconSize: 20,
                            ),
                            controller: confirmPasswordController,
                          ),
                          const SizedBox(height: 76),
                          isLoading
                              ? const Center(
                                  child: CupertinoActivityIndicator(),
                                )
                              : CustomElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (widget.email == null ||
                                          widget.otp == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Missing email or OTP info',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      context
                                          .read<ResetPasswordCubit>()
                                          .resetPassword(
                                            email: widget.email!,
                                            otp: widget.otp!,
                                            newPassword:
                                                newPasswordController.text,
                                          );
                                    }
                                  },
                                  text: 'Reset Password',
                                ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
