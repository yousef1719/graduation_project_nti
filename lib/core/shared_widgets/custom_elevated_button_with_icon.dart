import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    super.key,
    this.style,
    required this.text,
    required this.icon,
    required this.textColor,
    required this.iconColor,
    this.onPressed,
  });
  final void Function()? onPressed;
  final ButtonStyle? style;
  final String text;
  final IconData icon;
  final Color textColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      iconAlignment: IconAlignment.end,
      onPressed: onPressed,
      label: Center(
        child: CustomText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      icon: Icon(icon, color: textColor, size: 18),
      style:
          style ??
          ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(140, 40),
            backgroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
    );
  }
}
