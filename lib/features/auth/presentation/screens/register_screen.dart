// ignore_for_file: use_build_context_synchronously
<<<<<<< HEAD
=======

>>>>>>> 6e6ffc2 (Save current changes before pull)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_images.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_outlined_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/login_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/verification_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isActive = false;
  bool? isCheckBoxActive = false;
  bool isLoading = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;
    if (isCheckBoxActive != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.show(
          message: 'Please accept terms and conditions',
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    setState(() => isLoading = true);
    try {
      final success = await authRepo.signup(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                VerificationScreen(email: emailController.text.trim()),
          ),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (e is ApiError) {
        if (e.message.contains('Email is already in use')) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.show(
              message: 'This email is already registered. Please login.',
              backgroundColor: Colors.orange.shade700,
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false, // يمسح كل الصفحات القديمة من الـ stack
            );
          });
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.show(
            message: e.message,
            backgroundColor: Colors.red.shade800,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.show(
            message: 'Unknown error occurred',
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      text: 'Create Account',
                      fontSize: 32,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: 'Sign up to discover exclusive accessories.',
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      labelText: "First Name",
                      hintText: "Enter your first name",
                      validator: (pass) {
                        return Validator.validateUserName(pass!);
                      },
                      controller: firstNameController,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      labelText: "Last Name",
                      hintText: "Enter your last name",
                      validator: (pass) {
                        return Validator.validateUserName(pass!);
                      },
                      controller: lastNameController,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      labelText: "Email Address",
                      hintText: "name@example.com",
                      validator: (pass) {
                        return Validator.validateEmail(pass!);
                      },
                      controller: emailController,
                    ),
                    SizedBox(height: 10),
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
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).textTheme.bodySmall?.color,
                        iconSize: 20,
                      ),
                      controller: passwordController,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isCheckBoxActive,
                          checkColor: Colors.white,
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (newValue) {
                            setState(() {
                              isCheckBoxActive = newValue;
                            });
                          },
                        ),
                        Expanded(
                          child: CustomText(
                            text:
                                'I agree to the Terms & Conditions and Privacy Policy.',
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    isLoading
                        ? Center(child: const CupertinoActivityIndicator())
                        : CustomElevatedButton(
                            onPressed: signup,
                            text: 'Register',
                          ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        CustomText(
                          text: '   Or sign up with   ',
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Already have an account?',
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false,
                            );
                          },
                          child: CustomText(
                            text: 'Login',
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
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
  }
}
