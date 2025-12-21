// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/constants/app_images.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/splash/presentation/screens/onboarding_screen.dart';
import 'package:graduation_project_nti/features/splash/presentation/widgets/custom_indicator_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double progress = 0.0;
  late Timer timer;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _titleSlide;
  late Animation<Offset> _subtitleSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _titleSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
          ),
        );
    _subtitleSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );
    _controller.forward();
    timer = Timer.periodic(const Duration(milliseconds: 35), (timer) {
      setState(() {
        progress += 0.01;
        if (progress >= 1.0) {
          timer.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      color: progress < 0.5 ? Colors.white : AppColors.backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          blurRadius: 50,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(AppImages.logo),
                  ),
                ),
              ),
              SlideTransition(
                position: _titleSlide,
                child: const Text(
                  'Luxe',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Playfair',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SlideTransition(
                position: _subtitleSlide,
                child: CustomText(
                  text: 'Premium Accessories',
                  fontSize: 16,
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              CustomIndicatorWidget(value: progress),
              const SizedBox(height: 30),
              CustomText(
                text: 'version 1.0',
                fontSize: 12,
                color: AppColors.hintTextColor,
                fontWeight: FontWeight.w400,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
