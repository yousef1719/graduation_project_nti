// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/profile/data/models/settings_item_model.dart';

class CustomSettingsTile extends StatefulWidget {
  final SettingsItemModel item;

  const CustomSettingsTile({super.key, required this.item});

  @override
  State<CustomSettingsTile> createState() => _CustomSettingsTileState();
}

class _CustomSettingsTileState extends State<CustomSettingsTile> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xffFEEBE8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(widget.item.icon, color: AppColors.primaryColor),
      ),
      title: widget.item.subtitle.isEmpty
          ? CustomText(
              text: widget.item.title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.item.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
                CustomText(
                  text: widget.item.subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.hintTextColor,
                ),
              ],
            ),
      trailing: widget.item.hasSwitch
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isSwitched = !isSwitched;
                });
              },
              child: Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: isSwitched,
                  onChanged: (v) {
                    setState(() {
                      isSwitched = v;
                    });
                  },

                  activeColor: Colors.green,
                  trackColor: AppColors.hintTextColor.withOpacity(0.5),
                ),
              ),
            )
          : const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.hintTextColor,
            ),
      onTap: widget.item.onTap,
    );
  }
}
