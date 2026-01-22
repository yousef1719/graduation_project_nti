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
import 'package:graduation_project_nti/features/auth/presentation/screens/login_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/privacy_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/verification_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';

import 'package:graduation_project_nti/features/auth/presentation/cubit/register_cubit.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscurePassword = true;
  bool isTermsAccepted = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => RegisterCubit(AuthRepo()),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: 'Account created successfully 🎉',
                backgroundColor: Colors.green.shade700,
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerificationScreen(email: emailController.text.trim()),
              ),
            );
          }

          if (state is RegisterError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            if (state.message.contains('email is already in use') || state.message.contains('registered')) {
               ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.show(
                  message: 'This email is already registered. Please login.',
                  backgroundColor: Colors.orange.shade700,
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.show(
                  message: state.message,
                  backgroundColor: theme.colorScheme.error,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoading;

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
                            text: 'Create Account',
                            fontSize: 32,
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: 'Sign up to discover exclusive accessories.',
                            fontSize: 14,
                            color: theme.textTheme.bodySmall?.color,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            labelText: "First Name",
                            hintText: "Enter your first name",
                            validator: (val) => Validator.validateUserName(val!),
                            controller: firstNameController,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            labelText: "Last Name",
                            hintText: "Enter your last name",
                            validator: (val) => Validator.validateUserName(val!),
                            controller: lastNameController,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            labelText: "Email Address",
                            hintText: "name@example.com",
                            validator: (val) => Validator.validateEmail(val!),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            labelText: "Password",
                            hintText: "Create a password",
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
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isTermsAccepted,
                                checkColor: Colors.white,
                                activeColor: theme.colorScheme.primary,
                                onChanged: (newValue) {
                                  setState(() {
                                    isTermsAccepted = newValue ?? false;
                                  });
                                },
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                     Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                                    );
                                  },
                                  child: CustomText(
                                    text: 'I agree to the Terms & Conditions and Privacy Policy.',
                                    fontSize: 12,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          isLoading
                              ? const Center(child: CupertinoActivityIndicator())
                              : CustomElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (!isTermsAccepted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          CustomSnackBar.show(
                                            message: 'Please accept terms and conditions',
                                            backgroundColor: Colors.orange,
                                          ),
                                        );
                                        return;
                                      }
                                      context.read<RegisterCubit>().signup(
                                            firstName: firstNameController.text.trim(),
                                            lastName: lastNameController.text.trim(),
                                            email: emailController.text.trim(),
                                            password: passwordController.text.trim(),
                                          );
                                    }
                                  },
                                  text: 'Register',
                                ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(child: Divider(thickness: 1)),
                              CustomText(
                                text: '   Or sign up with   ',
                                fontSize: 14,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                              const Expanded(child: Divider(thickness: 1)),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Already have an account?',
                                fontSize: 14,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                                    (route) => false,
                                  );
                                },
                                child: CustomText(
                                  text: 'Login',
                                  fontSize: 14,
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
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
