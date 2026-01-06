import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/products/presentation/screens/add_new_product.dart';
import 'package:graduation_project_nti/root.dart';

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
          bodyMedium: TextStyle(fontFamily: 'PlusJakartaSans'),
        ),
      ),
      home: AddNewProduct(),
      // Root(),
    );
  }
}
