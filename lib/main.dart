import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/Create_password_Screen.dart';

void main() {
  runApp(const GraduationProjectNti());
}

class GraduationProjectNti extends StatelessWidget {
  const GraduationProjectNti({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreatePasswordScreen(),
    );
  }
}
