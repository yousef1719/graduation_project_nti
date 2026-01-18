// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text_button.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:graduation_project_nti/features/profile/data/repo/profile_repo.dart';

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

  final ProfileRepo profileRepo = ProfileRepo();
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    if (newPasswordController.text != confirmNewPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.show(
          message: 'Passwords do not match',
          backgroundColor: Colors.red.shade800,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await profileRepo.changePassword(
        currentPasswordController.text.trim(),
        newPasswordController.text.trim(),
        confirmNewPasswordController.text.trim(),
      );

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.show(
          message: 'Password changed successfully ✅',
          backgroundColor: Colors.green.shade700,
        ),
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context);
    } catch (e) {
      setState(() => isLoading = false);

      String errorMsg = 'Failed to change password';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          onPressedLeading: () {
            Navigator.pop(context);
          },
          title: 'Change Password',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:
                      'Your new password must be different from\nprevious used passwords.',
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodySmall?.color,
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
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodySmall?.color,
                    iconSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      text: 'Forget Password?',
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
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
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodySmall?.color,
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
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodySmall?.color,
                    iconSize: 20,
                  ),
                ),
                SizedBox(height: 70),
                isLoading
                    ? const Center(child: CupertinoActivityIndicator())
                    : CustomElevatedButton(
                        onPressed: changePassword,
                        text: 'Change Password',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
