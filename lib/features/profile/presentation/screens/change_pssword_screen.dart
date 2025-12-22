import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text_button.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool isCurrentVisible = false;
  bool isNewVisible = false;
  bool isConfirmVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(onPressedLeading: () {}, title: 'Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    'Your new password must be different from\nprevious used passwords.',
                fontSize: 14,
                color: AppColors.hintTextColor,
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Current Password',
                hintText: 'Enter current password',
                controller: currentPasswordController,
                obscureText: isCurrentVisible,
                validator: (pass) {
                  return Validator.validatePassword(pass!);
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isCurrentVisible = !isCurrentVisible;
                    });
                  },
                  icon: Icon(
                    isCurrentVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: isCurrentVisible
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  iconSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    text: 'Forget Password?',
                    fontSize: 12,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              CustomTextField(
                labelText: 'New Password',
                hintText: 'Enter new password',
                controller: newPasswordController,
                obscureText: isNewVisible,
                validator: (pass) {
                  return Validator.validatePassword(pass!);
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isNewVisible = !isNewVisible;
                    });
                  },
                  icon: Icon(
                    isNewVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: isNewVisible
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  iconSize: 20,
                ),
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Confirm New Password',
                hintText: 'Re-enter new password',
                controller: confirmNewPasswordController,
                obscureText: isConfirmVisible,
                validator: (pass) {
                  return Validator.validatePassword(pass!);
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isConfirmVisible = !isConfirmVisible;
                    });
                  },
                  icon: Icon(
                    isConfirmVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  color: isConfirmVisible
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                  iconSize: 20,
                ),
              ),
              SizedBox(height: 70),
              CustomElevatedButton(onPressed: () {}, text: 'Change Password'),
            ],
          ),
        ),
      ),
    );
  }
}
