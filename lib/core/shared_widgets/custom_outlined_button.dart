import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/constants/app_images.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.image,
  });
  final String text;
  final void Function()? onPressed;
  final String image;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.backgroundColor,
        side: BorderSide(color: AppColors.hintTextColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 12),
        minimumSize: Size(double.infinity, 48),
      ),
      icon: SvgPicture.asset(image, width: 20),
      label: CustomText(
        text: text,
        fontSize: 14,
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
