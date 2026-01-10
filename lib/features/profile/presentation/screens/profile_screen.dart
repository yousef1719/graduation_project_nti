// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/header_profile_section.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: CustomAppBar(leading: SizedBox.shrink(), title: 'Profile'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HeaderProfileSection()),
          ProfileScreenBody(),
        ],
      ),
    );
  }
}
