import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: theme.colorScheme.onSurface,
            ),
          ),
          title: 'Privacy Policy',
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last updated: October 24, 2023',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              Text(
                'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile application to shop for accessories. By using our app, you agree to the collection and use of information in accordance with this policy.',
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 30),

              _buildSectionTitle(context, '1', 'Information We Collect'),
              _buildSectionContent(
                context,
                'We collect several types of information to provide and improve our service to you:\n\n'
                '• Personal Data: Name, shipping address, email address, and phone number required for order processing.\n'
                '• Payment Data: Payment details processed securely by third-party payment processors.\n'
                '• Usage Data: Information on how you access and use the app, including device information and interaction history.',
              ),

              _buildSectionTitle(context, '2', 'How We Use Your Data'),
              _buildSectionContent(
                context,
                'The data collected is used to manage your account, process orders, and enhance your shopping experience. Specifically, we use it for:\n\n'
                '• Order Fulfillment\n'
                '• Personalization\n'
                '• Customer Support',
              ),

              _buildSectionTitle(context, '3', 'Data Protection'),
              _buildSectionContent(
                context,
                'We implement a variety of security measures to maintain the safety of your personal information. Your data is contained behind secured networks and is only accessible by a limited number of persons who have special access rights to such systems.',
              ),

              _buildSectionTitle(context, '4', 'Contact Us'),
              _buildSectionContent(
                context,
                'If you have any questions regarding this privacy policy, you may contact us using the information below:\n\n'
                '📧 support@accessories-app.com',
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String number, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        content,
        style: theme.textTheme.bodyMedium?.copyWith(
          height: 1.6,
          color: theme.textTheme.bodyMedium?.color?.withAlpha(179),
        ),
      ),
    );
  }
}
