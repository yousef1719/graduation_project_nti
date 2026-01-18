import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.hintText,
    required this.color,
    required this.backgroundColor,
  });
  final IconData icon;
  final String text;
  final String hintText;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 192.81,
      height: 144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            IconButton(
              style: IconButton.styleFrom(backgroundColor: backgroundColor),
              onPressed: () {},
              icon: Icon(icon),
              color: color,
            ),
            SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 4),
            Text(
              hintText,
              style: TextStyle(
                color: AppColors.hintTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
