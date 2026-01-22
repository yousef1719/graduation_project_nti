// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/data/repo/auth_repo.dart';
import 'package:graduation_project_nti/features/auth/data/models/verification_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isActive = true;
  bool isLoading = false;
  bool canVerify = true;
  int retrySeconds = 3;
  Timer? resendTimer;
  int resendSeconds = 30;
  final FocusNode pinFocusNode = FocusNode();
  final TextEditingController pinTextController = TextEditingController();

  String shortEmailKeepDomain(String email, {int maxUserLength = 5}) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final user = parts[0];
    final domain = parts[1];

    if (user.length <= maxUserLength) return email;

    return '${user.substring(0, maxUserLength)}...@$domain';
  }

  void _startCooldown() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => canVerify = true);
      }
    });
  }

  void startResendTimer() {
    resendTimer?.cancel(); // لو شغال قبل كده

    setState(() {
      resendSeconds = 30;
    });

    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel(); // لو الشاشة اتقفلت، وقف الـ timer فورًا
        return;
      }
      if (resendSeconds == 0) {
        timer.cancel();
      } else {
        if (!mounted) return;
        setState(() {
          resendSeconds--;
        });
      }
    });
  }

  AuthRepo authRepo = AuthRepo();
  Future<void> verifyEmail() async {
    if (!canVerify || isLoading) return;
    if (pinTextController.text.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter the 6-digit code')));
      return;
    }
    setState(() {
      {
        isLoading = true;
        canVerify = false;
      }
    });

    try {
      final VerificationModel response = await authRepo.verifyEmail(
        widget.email,
        pinTextController.text.trim(),
      );

      if (response.success == true) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.show(
            message: 'Email verified successfully',
            backgroundColor: Colors.green.shade700,
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.show(
            message: response.message ?? 'Verification failed',
            backgroundColor: Colors.red.shade800,
          ),
        );
        if (mounted) pinTextController.clear();
        pinFocusNode.requestFocus();
        _startCooldown();
        startResendTimer();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar.show(
          message: 'Something went wrong',
          backgroundColor: Colors.red.shade800,
        ),
      );
      if (mounted) pinTextController.clear();
      pinFocusNode.requestFocus();
      _startCooldown();
      startResendTimer();
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> resendOtp() async {
    //  await authRepo.resendOtp(widget.email);
    startResendTimer(); // 🔥 مهم
  }

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0x1A37131A),
                      minimumSize: Size(80, 80),
                    ),
                    icon: Icon(
                      isActive ? Icons.lock_open : Icons.lock,
                      color: Theme.of(context).colorScheme.primary,
                      size: 35,
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomText(
                    text: 'Verification',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'We sent a code to',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5),
                      CustomText(
                        text: shortEmailKeepDomain(widget.email),
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  PinCodeTextField(
                    focusNode: pinFocusNode,
                    appContext: context,
                    length: 6,
                    controller: pinTextController,
                    keyboardType: TextInputType.number,
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 56,
                      fieldWidth: 45,
                      inactiveColor:
                          Theme.of(
                            context,
                          ).textTheme.bodySmall?.color?.withOpacity(0.3) ??
                          Colors.grey.withOpacity(0.3),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      activeColor: Theme.of(context).colorScheme.primary,
                      activeFillColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      selectedFillColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      inactiveFillColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                    ),
                    enableActiveFill: true,
                    onChanged: (value) {},
                    onCompleted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Didn't receive the code?",
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(width: 6),
                      InkWell(
                        onTap: resendSeconds == 0 ? resendOtp : null,
                        child: CustomText(
                          text: resendSeconds == 0
                              ? 'Resend code'
                              : 'Resend (0:${resendSeconds.toString().padLeft(2, '0')})',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: resendSeconds == 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  CustomElevatedButton(
                    onPressed: (isLoading || !canVerify)
                        ? null
                        : () => verifyEmail(),
                    text: isLoading
                        ? 'Verifying...'
                        : !canVerify
                        ? 'Try again...'
                        : 'Verify',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
