import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/register_screen.dart';

void main() {
  runApp(const GraduationProjectNti());
}

class GraduationProjectNti extends StatelessWidget {
  const GraduationProjectNti({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/register_screen': (context) => RegisterScreen()},
      initialRoute: '/register_screen',
      title: 'E-commerce',
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}
