import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:graduation_project_nti/core/constants/app_colors.dart';
>>>>>>> 6e6ffc2 (Save current changes before pull)

class CustomContainerScreen extends StatelessWidget {
  const CustomContainerScreen({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
<<<<<<< HEAD
        color: Theme.of(context).cardColor,
=======
        color: AppColors.backgroundColor,
>>>>>>> 6e6ffc2 (Save current changes before pull)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
<<<<<<< HEAD
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            Icon(Icons.add, color: Theme.of(context).textTheme.bodySmall?.color),
=======
                color: AppColors.textColor,
              ),
            ),
            Icon(Icons.add, color: AppColors.hintTextColor),
>>>>>>> 6e6ffc2 (Save current changes before pull)
          ],
        ),
      ),
    );
  }
}
