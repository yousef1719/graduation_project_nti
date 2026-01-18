import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/splash/presentation/widgets/custom_background_onbrdg.dart';
import 'package:graduation_project_nti/features/splash/presentation/widgets/custom_body_onboarding.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomBackgroundOnbrdg(),
          const SizedBox(height: 20),
          CustomBodyOnboarding(),
        ],
      ),
    );
  }
}
