// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/helpers/pref_helper.dart';
import 'package:graduation_project_nti/core/network/api_error.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button_with_icon.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/login_screen.dart';
import 'package:graduation_project_nti/features/auth/presentation/screens/privacy_screen.dart';
import 'package:graduation_project_nti/features/profile/data/models/settings_item_model.dart';
import 'package:graduation_project_nti/features/profile/data/repo/profile_repo.dart';
import 'package:graduation_project_nti/features/profile/presentation/screens/about_us.dart';
import 'package:graduation_project_nti/features/profile/presentation/screens/change_pssword_screen.dart';
import 'package:graduation_project_nti/features/profile/presentation/screens/help_screen.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/settings_section.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});
  Future<void> logout(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final token = await PrefHelper.getToken();
    if (token == null || token.isEmpty) {
      scaffoldMessenger.showSnackBar(
        CustomSnackBar.show(
          message: 'You are not logged in 👀',
          backgroundColor: Colors.orange.shade700,
        ),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false,
      );
      return;
    }
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CupertinoActivityIndicator()),
      );
      final profileRepo = ProfileRepo();
      await profileRepo.logout();
      scaffoldMessenger.showSnackBar(
        CustomSnackBar.show(
          message: 'Logout successful 👋',
          backgroundColor: Colors.green.shade700,
        ),
      );
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
        );
      });
    } catch (e) {
      String errorMsg = 'Error in logout';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      scaffoldMessenger.showSnackBar(
        CustomSnackBar.show(
          message: errorMsg,
          backgroundColor: Colors.red.shade800,
        ),
      );
    } finally {
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SettingsSection(
          title: "Account Settings",
          items: [
            SettingsItemModel(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChangePasswordScreen(),
                  ),
                );
              },
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
              icon: CupertinoIcons.doc,
              title: "Privacy Policy",
              subtitle: "",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                );
                SettingsItemModel(
                  icon: CupertinoIcons.question_circle,
                  title: "Help Center",
                  subtitle: "",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpScreen()),
                    );
                  },
                );
              },
            ),
            SettingsItemModel(
              icon: CupertinoIcons.info,
              title: "About Us",
              subtitle: "",

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomElevatedButtonWithIcon(
            icon: Icons.logout,
            text: 'Logout',
            onPressed: () => logout(context),
            textColor: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.primary,
            style: ElevatedButton.styleFrom(
              iconAlignment: IconAlignment.start,
              elevation: 2,
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomText(
            text: 'Version 1.0.4 • Build 2023',
            fontSize: 12,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
