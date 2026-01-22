import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomSnackBar {
  static SnackBar show({
    required String message,
    Color backgroundColor = Colors.red,
  }) {
    return SnackBar(
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: backgroundColor,
      content: CustomText(text: message, fontSize: 14, color: Colors.white),
    );
  }
}
