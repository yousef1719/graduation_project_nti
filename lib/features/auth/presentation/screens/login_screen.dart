// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/constants/app_images.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_outlined_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/data/auth_repo.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:graduation_project_nti/root.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isActive = false;

  AuthRepo authRepo = AuthRepo();
  bool isLoading = false;
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    try {
      final loginData = await authRepo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      setState(() => isLoading = false);

      if (loginData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.show(
            message: 'Login successful 🎉',
            backgroundColor: Colors.green.shade700,
          ),
        );

        await Future.delayed(const Duration(seconds: 1));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Root()),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      String errorMsg = 'Error in Login';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.show(
          message: errorMsg,
          backgroundColor: Colors.red.shade800,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                    SizedBox(height: 30),
                    CustomText(
                      text: 'Welcome Back',
                      fontSize: 32,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text:
                          'Log in to discover the latest trends in accessories.',
                      fontSize: 14,
                      color: AppColors.hintTextColor,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: "Email Address",
                      hintText: "name@example.com",
                      validator: (pass) {
                        return Validator.validateEmail(pass!);
                      },
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: "Password",
                      hintText: "Create a password",
                      obscureText: !isActive,
                      validator: (pass) {
                        return Validator.validatePassword(pass!);
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        },
                        icon: Icon(
                          isActive
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        color: isActive
                            ? AppColors.primaryColor
                            : AppColors.hintTextColor,
                        iconSize: 20,
                      ),
                      controller: passwordController,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: CustomText(
                          text: 'Forgot Password?',
                          fontSize: 12,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? Center(child: const CupertinoActivityIndicator())
                        : CustomElevatedButton(onPressed: login, text: 'Login'),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        CustomText(
                          text: '   Or sign in with   ',
                          fontSize: 14,
                          color: AppColors.hintTextColor,
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CustomOutlinedButton(
                            text: 'Google',
                            image: AppImages.googleLogo,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomOutlinedButton(
                            text: 'Facebook',
                            image: AppImages.facbookLogo,
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
                          color: AppColors.hintTextColor,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: CustomText(
                            text: 'Sign Up',
                            fontSize: 14,
                            color: AppColors.primaryColor,
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
  }
}
