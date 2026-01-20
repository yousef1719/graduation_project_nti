import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class BuildSectionHeader extends StatelessWidget {
  const BuildSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.bgColor,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final Color bgColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        CustomText(text: title, fontSize: 18, fontWeight: FontWeight.bold),
      ],
    );
  }
}
