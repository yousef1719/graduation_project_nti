import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/Create_password_Screen.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
  listener: (context, state) {
    if (state is ForgotPasswordSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CreatePasswordScreen(),
        ),
      );
    }

    if (state is ForgotPasswordError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Reset link sent to your email"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Stack(
                    children: [
        
                      /// 🔙 Back Button (Top Left)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
        
                      /// Page Content
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
        
                            const SizedBox(height: 40),
        
                            /// Icon
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lock_reset,
                                color: Colors.red,
                                size: 36,
                              ),
                            ),
        
                            const SizedBox(height: 24),
        
                            /// Title
                            const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
        
                            const SizedBox(height: 12),
        
                            /// Description
                            const Text(
                              "Don't worry! It happens. Please enter the email address linked to your account.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
        
                            const SizedBox(height: 32),
        
                            /// Email Field
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Email Address",
                                prefixIcon: const Icon(Icons.email_outlined),
                                errorText: state is ForgotPasswordError
                                    ? state.message
                                    : null,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
        
                            const SizedBox(height: 24),
        
                            /// Button
                           BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
  listener: (context, state) {
    if (state is ForgotPasswordSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CreatePasswordScreen(),
        ),
      );
    }

    if (state is ForgotPasswordError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: state is ForgotPasswordLoading
          ? null
          : () {
              context
                  .read<ForgotPasswordCubit>()
                  .sendResetLink(emailController.text.trim());
            },
      child: state is ForgotPasswordLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              "Send Reset Link",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
    ),
  ),
),

        
                            const Spacer(),
        
                            /// Bottom Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Remember password? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
