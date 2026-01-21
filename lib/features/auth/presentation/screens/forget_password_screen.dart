import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/forgot_password_state.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/verification_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: 'Reset code sent to your email 📧',
                backgroundColor: Colors.green.shade700,
              ),
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerificationScreen(
                  email: emailController.text.trim(),
                  isForgotPassword: true,
                ),
              ),
            );
          }

          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: state.message,
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new, color: theme.colorScheme.onSurface),
              ),
              title: 'Forgot Password',
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    /// Icon
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withAlpha(25),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_reset,
                        color: theme.colorScheme.primary,
                        size: 36,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Title
                    Text(
                      "Forgot Password?",
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Description
                    Text(
                      "Don't worry! It happens. Please enter the email address linked to your account.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// Email Field
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        return TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            errorText: state is ForgotPasswordError
                                ? state.message
                                : null,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    /// Button
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: theme.elevatedButtonTheme.style?.copyWith(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            onPressed: state is ForgotPasswordLoading
                                ? null
                                : () {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .sendResetLink(
                                          emailController.text.trim(),
                                        );
                                  },
                            child: state is ForgotPasswordLoading
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Send Reset Link",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    /// Bottom Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember password? ",
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Login",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
