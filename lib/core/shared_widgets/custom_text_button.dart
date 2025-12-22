import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.fontSize,
    required this.color,
  });
  final void Function()? onPressed;
  final String text;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,

      child: CustomText(text: text, fontSize: fontSize, color: color),
    );
  }
}
