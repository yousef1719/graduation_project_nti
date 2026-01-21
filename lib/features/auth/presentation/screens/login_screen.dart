// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project_nti/core/constants/app_images.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_outlined_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:graduation_project_nti/root.dart';
import 'register_screen.dart';

import 'package:graduation_project_nti/features/auth/presentation/cubit/login_cubit.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => LoginCubit(AuthRepo()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: 'Login successful 🎉',
                backgroundColor: Colors.green.shade700,
              ),
            );

            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Root()),
              );
            });
          }

          if (state is LoginError) {
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
          final isLoading = state is LoginLoading;

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: PopScope(
              canPop: false,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SafeArea(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          CustomText(
                            text: 'Welcome Back',
                            fontSize: 32,
                            color: theme.textTheme.headlineLarge?.color ?? theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            text: 'Log in to discover the latest trends in accessories.',
                            fontSize: 14,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            labelText: "Email Address",
                            hintText: "name@example.com",
                            validator: (val) => Validator.validateEmail(val!),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            labelText: "Password",
                            hintText: "Enter your password",
                            obscureText: obscurePassword,
                            validator: (val) => Validator.validatePassword(val!),
                            controller: passwordController,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              color: !obscurePassword
                                  ? theme.colorScheme.primary
                                  : theme.textTheme.bodySmall?.color,
                              iconSize: 20,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: CustomText(
                                text: 'Forgot Password?',
                                fontSize: 12,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          isLoading
                              ? const Center(child: CupertinoActivityIndicator())
                              : CustomElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<LoginCubit>().login(
                                            emailController.text.trim(),
                                            passwordController.text.trim(),
                                          );
                                    }
                                  },
                                  text: 'Login',
                                ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Expanded(child: Divider(thickness: 1)),
                              CustomText(
                                text: '   Or sign in with   ',
                                fontSize: 14,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                              const Expanded(child: Divider(thickness: 1)),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: CustomOutlinedButton(
                                  text: 'Google',
                                  image: AppImages.googleLogo,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomOutlinedButton(
                                  text: 'Facebook',
                                  image: AppImages.facbookLogo,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Don\'t have an account? ',
                                fontSize: 14,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                                    (route) => false,
                                  );
                                },
                                child: CustomText(
                                  text: 'Sign Up',
                                  fontSize: 14,
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
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
