import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    super.key,
    this.style,
    required this.text,
    this.icon,
    required this.textColor,
    this.iconColor,
    this.onPressed,
  });
  final void Function()? onPressed;
  final ButtonStyle? style;
  final String text;
  final IconData? icon;
  final Color textColor;
  final Color? iconColor;

  @override
  @override
  Widget build(BuildContext context) {
    final buttonStyle =
        style ??
        ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(140, 40),
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
    if (icon == null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      );
    }
    return ElevatedButton.icon(
      iconAlignment: IconAlignment.end,
      onPressed: onPressed,
      style: buttonStyle,
      label: CustomText(
        text: text,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      icon: Icon(icon, color: iconColor ?? textColor, size: 18),
    );
  }
}
