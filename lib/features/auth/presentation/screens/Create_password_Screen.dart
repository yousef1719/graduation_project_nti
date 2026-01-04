// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/Header.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool isVisible = false;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8),
              Header(
                title: 'Create new password',
                subtitle:
                    'Your new password must be unique from those previsoly used.',
              ),
              SizedBox(height: 32),
              CustomTextField(
                labelText: "Password",
                hintText: "Create a password",
                obscureText: isVisible,
                validator: (pass) {
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
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: isVisible
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  iconSize: 20,
                ),
                controller: newPassword,
              ),
              SizedBox(height: 18),
              CustomTextField(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your new password',
                obscureText: isVisible,
                validator: (pass) {
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
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: isVisible
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  iconSize: 20,
                ),
                controller: newPassword,
              ),
              Card(),
              SizedBox(height: 76),
              CustomElevatedButton(onPressed: () {}, text: 'Reset Password'),
            ],
          ),
        ),
      ),
    );
  }
}
