import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onPressedLeading, this.title});
  final void Function()? onPressedLeading;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,
      title: CustomText(
        text: title ?? '',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      leading: IconButton(
        onPressed: onPressedLeading,
        icon: Icon(Icons.arrow_back_ios_new, color: AppColors.textColor),
      ),
    );
  }
}
