import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';

class PromoTextField extends StatelessWidget {
  const PromoTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primaryColor,
        decoration: const InputDecoration(
          hintText: "Enter code",
          hintStyle: TextStyle(color: Color(0xff9CA3AF)),
          prefixIcon: Icon(
            Icons.local_offer_outlined,
            color: Color(0xff9CA3AF),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
