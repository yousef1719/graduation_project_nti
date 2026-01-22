// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button_with_icon.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/profile/presentation/screens/help_screen.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/build_section_header.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/feature_card.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: 'About Us',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/background/about_banner.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(20),
              child: CustomText(
                text: "Crafting Style Since 2018",
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                // color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            BuildSectionHeader(
              icon: Icons.diamond_outlined,
              title: "Our Mission",
              bgColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              iconColor: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 15),
              child: CustomText(
                text:
                    'We believe that accessories are more than just additions to an outfit—they are expressions of personality. Our mission is to curate unique, high- quality pieces that empower you to shine every day.',
                fontSize: 14,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            BuildSectionHeader(
              icon: Icons.visibility_outlined,
              title: "Our Vision",
              bgColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              iconColor: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 15),
              child: CustomText(
                text:
                    'To become the global destination for modern accessories, bridging the gap between luxury design and accessible fashion for trendsetters everywhere.',
                fontSize: 14,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            CustomText(
              text: "What We Offer",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 15),
            const FeatureCard(
              icon: Icons.verified_outlined,
              title: "Authentic Quality",
              description: "Hand-picked materials for excellence.",
            ),
            const FeatureCard(
              icon: Icons.local_shipping_outlined,
              title: "Global Delivery",
              description: "Secure shipping worldwide.",
            ),
            const SizedBox(height: 20),
            CustomElevatedButtonWithIcon(
              text: 'Contact Us',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpScreen()),
                );
              },
              textColor: Theme.of(context).colorScheme.primary,
              style: ElevatedButton.styleFrom(
                elevation: 2,
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
