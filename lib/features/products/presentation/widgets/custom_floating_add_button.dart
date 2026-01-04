import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';

class CustomFloatingAddButton extends StatelessWidget {
  const CustomFloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      shape: const CircleBorder(),
      color: AppColors.primaryColor,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (_) => AddProductScreen(),
          // ));
        },
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
