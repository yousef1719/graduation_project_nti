

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/create_password_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/login_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:graduation_project_nti/features/auth/presentation/cubit/verification_cubit.dart';
import 'package:graduation_project_nti/features/auth/presentation/cubit/verification_state.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
    required this.email,
    this.isForgotPassword = false,
  });
  final String email;
  final bool isForgotPassword;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? resendTimer;
  int resendSeconds = 30;
  final FocusNode pinFocusNode = FocusNode();
  final TextEditingController pinTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    resendTimer?.cancel();
    resendSeconds = 30;
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (resendSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          resendSeconds--;
        });
      }
    });
  }

  String shortEmailKeepDomain(String email, {int maxUserLength = 5}) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final user = parts[0];
    final domain = parts[1];
    if (user.length <= maxUserLength) return email;
    return '${user.substring(0, maxUserLength)}...@$domain';
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    pinTextController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => VerificationCubit(AuthRepo()),
      child: BlocConsumer<VerificationCubit, VerificationState>(
        listener: (context, state) {
          if (state is VerificationSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: 'Email verified successfully 🎉',
                backgroundColor: Colors.green.shade700,
              ),
            );
            // Navigate to finish login or reset password depending on flow
            Future.delayed(const Duration(seconds: 2), () {
              if (!context.mounted) return;
              if (widget.isForgotPassword) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreatePasswordScreen(
                      email: widget.email,
                      otp: pinTextController.text.trim(),
                    ),
                  ),
                );
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            });
          }

          if (state is VerificationError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.show(
                message: state.message,
                backgroundColor: theme.colorScheme.error,
              ),
            );
            pinTextController.clear();
            pinFocusNode.requestFocus();
          }
        },
        builder: (context, state) {
          final isLoading = state is VerificationLoading;

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(
                onPressedLeading: () => Navigator.pop(context),
              ),
            ),
            body: PopScope(
              canPop: false,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_person_outlined,
                            color: theme.colorScheme.primary,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CustomText(
                          text: 'Verification',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'We sent a code to ',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            Flexible(
                              child: CustomText(
                                text: shortEmailKeepDomain(widget.email),
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        PinCodeTextField(
                          focusNode: pinFocusNode,
                          appContext: context,
                          length: 6,
                          controller: pinTextController,
                          keyboardType: TextInputType.number,
                          autoFocus: true,
                          textStyle: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 56,
                            fieldWidth: 45,
                            inactiveColor: theme.dividerColor,
                            selectedColor: theme.colorScheme.primary,
                            activeColor: theme.colorScheme.primary,
                            activeFillColor: theme.cardColor,
                            selectedFillColor: theme.cardColor,
                            inactiveFillColor: theme.cardColor,
                          ),
                          enableActiveFill: true,
                          onChanged: (value) {},
                          onCompleted: (code) {
                            if (widget.isForgotPassword) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreatePasswordScreen(
                                    email: widget.email,
                                    otp: code,
                                  ),
                                ),
                              );
                            } else {
                              context.read<VerificationCubit>().verifyEmail(
                                widget.email,
                                code,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Didn't receive the code? ",
                              fontSize: 14,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            InkWell(
                              onTap: resendSeconds == 0
                                  ? () {
                                      startResendTimer();
                                      // TODO: Trigger resend API
                                    }
                                  : null,
                              child: CustomText(
                                text: resendSeconds == 0
                                    ? 'Resend code'
                                    : 'Resend (0:${resendSeconds.toString().padLeft(2, '0')})',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: resendSeconds == 0
                                    ? theme.colorScheme.primary
                                    : theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        isLoading
                            ? const CupertinoActivityIndicator()
                            : CustomElevatedButton(
                                onPressed: () {
                                  if (pinTextController.text.length == 6) {
                                    if (widget.isForgotPassword) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CreatePasswordScreen(
                                            email: widget.email,
                                            otp: pinTextController.text.trim(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      context
                                          .read<VerificationCubit>()
                                          .verifyEmail(
                                            widget.email,
                                            pinTextController.text.trim(),
                                          );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please enter the 6-digit code',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                text: 'Verify',
                              ),
                      ],
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
