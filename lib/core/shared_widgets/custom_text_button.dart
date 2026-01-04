import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.fontSize,
    required this.color,
    this.style,
    this.fontWeight,
  });
  final void Function()? onPressed;
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style,
      child: CustomText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
