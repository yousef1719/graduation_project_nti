import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:graduation_project_nti/core/constants/app_colors.dart';
>>>>>>> 6e6ffc2 (Save current changes before pull)

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.hintText,
    required this.color,
<<<<<<< HEAD
    this.backgroundColor,
=======
    required this.backgroundColor,
>>>>>>> 6e6ffc2 (Save current changes before pull)
  });
  final IconData icon;
  final String text;
  final String hintText;
  final Color color;
<<<<<<< HEAD
  final Color? backgroundColor;
=======
  final Color backgroundColor;
>>>>>>> 6e6ffc2 (Save current changes before pull)

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
=======
>>>>>>> 6e6ffc2 (Save current changes before pull)
      width: 192.81,
      height: 144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
<<<<<<< HEAD
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            style: IconButton.styleFrom(backgroundColor: backgroundColor),
            onPressed: () {},
            icon: Icon(icon),
            color: color,
          ),
          SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 4),
          Text(
            hintText,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ],
=======
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
>>>>>>> 6e6ffc2 (Save current changes before pull)
      ),
    );
  }
}
