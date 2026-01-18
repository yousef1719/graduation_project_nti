import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.fontFamily,
    this.maxLines,
  });
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? 'PlusJakartaSans',
      ),
    );
  }
}
