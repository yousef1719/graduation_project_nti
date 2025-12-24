import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/constants/app_images.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_outlined_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/login_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isActive = false;
  bool? isCheckBoxActive = false;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          onPressedLeading: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Create Account',
                  fontSize: 32,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: 'Sign up to discover exclusive accessories.',
                  fontSize: 14,
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 30),
                CustomTextField(
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                  validator: (pass) {
                    return Validator.validateUserName(pass!);
                  },
                  controller: fullNameController,
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
                  obscureText: isActive,
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isCheckBoxActive,
                      checkColor: Colors.white,
                      activeColor: Color(0xffEC3713),
                      onChanged: (newValue) {
                        setState(() {
                          isCheckBoxActive = newValue;
                        });
                        log(isCheckBoxActive.toString());
                      },
                    ),
                    Expanded(
                      child: CustomText(
                        text:
                            'I agree to the Terms & Conditions and Privacy Policy.',
                        fontSize: 12,
                        color: AppColors.hintTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomElevatedButton(onPressed: () {}, text: 'Register'),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    CustomText(
                      text: '   Or sign up with   ',
                      fontSize: 14,
                      color: AppColors.hintTextColor,
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
                      color: AppColors.hintTextColor,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: CustomText(
                        text: 'Login',
                        fontSize: 14,
                        color: AppColors.primaryColor,
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
    );
  }
}
