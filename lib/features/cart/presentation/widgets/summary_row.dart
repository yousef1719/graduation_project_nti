import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBold;

  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: const Color(0xff111827),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: value == "Free"
                  ? AppColors.primaryColor
                  : const Color(0xff111827),
            ),
          ),
        ],
      ),
    );
  }
}
