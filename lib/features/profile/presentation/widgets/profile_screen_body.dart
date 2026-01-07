// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button_with_icon.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/profile/data/models/settings_item_model.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/settings_section.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SettingsSection(
          title: "Account Settings",
          items: [
            SettingsItemModel(
              icon: CupertinoIcons.lock,
              title: "Change Password",
              subtitle: "Update your security",
            ),
            SettingsItemModel(
              icon: CupertinoIcons.bell,
              title: "Notifications",
              subtitle: "Manage push alerts",
            ),
          ],
        ),
        SettingsSection(
          title: "App Settings",
          items: [
            SettingsItemModel(
              icon: CupertinoIcons.moon,
              title: "Dark Mode",
              subtitle: "Reduce eye strain",
              hasSwitch: true,
            ),
          ],
        ),

        SettingsSection(
          title: "Support & Information",
          items: [
            SettingsItemModel(
              icon: CupertinoIcons.phone,
              title: "Contact Us",
              subtitle: "",
            ),
            SettingsItemModel(
              icon: CupertinoIcons.doc,
              title: "Privacy Policy",
              subtitle: "",
            ),
            SettingsItemModel(
              icon: CupertinoIcons.info,
              title: "About Us",
              subtitle: "",
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomElevatedButtonWithIcon(
            icon: Icons.logout,
            text: 'Logout',
            onPressed: () {},
            textColor: AppColors.primaryColor,
            iconColor: AppColors.primaryColor,
            style: ElevatedButton.styleFrom(
              iconAlignment: IconAlignment.start,
              elevation: 2,
              minimumSize: const Size.fromHeight(50),
              backgroundColor: AppColors.backgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.primaryColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomText(
            text: 'Version 1.0.4 • Build 2023',
            fontSize: 12,
            color: AppColors.hintTextColor,
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
