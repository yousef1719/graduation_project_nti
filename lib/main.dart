import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(const GraduationProjectNti());
}

class GraduationProjectNti extends StatelessWidget {
  const GraduationProjectNti({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Graduation Project NTI',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Playfair'),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
