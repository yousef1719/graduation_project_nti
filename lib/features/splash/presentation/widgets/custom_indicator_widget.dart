import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';

class CustomIndicatorWidget extends StatelessWidget {
  const CustomIndicatorWidget({super.key, required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(50),
        minHeight: 6,
        value: value,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        semanticsLabel: 'Linear progress indicator',
        semanticsValue: '50%',
        color: AppColors.primaryColor,
        backgroundColor: Color(0xffF8E3E0),
      ),
    );
  }
}
