import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last updated: October 24, 2023',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile application to shop for accessories. By using our app, you agree to the collection and use of information in accordance with this policy.',
              style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            
            
            _buildSectionTitle('1', 'Information We Collect'),
            _buildSectionContent(
              'We collect several types of information to provide and improve our service to you:\n\n'
              '• Personal Data: Name, shipping address, email address, and phone number required for order processing.\n'
              '• Payment Data: Payment details processed securely by third-party payment processors.\n'
              '• Usage Data: Information on how you access and use the app, including device information and interaction history.'
            ),

            _buildSectionTitle('2', 'How We Use Your Data'),
            _buildSectionContent(
              'The data collected is used to manage your account, process orders, and enhance your shopping experience. Specifically, we use it for:\n\n'
              '• Order Fulfillment\n'
              '• Personalization\n'
              '• Customer Support'
            ),

            _buildSectionTitle('3', 'Data Protection'),
            _buildSectionContent(
              'We implement a variety of security measures to maintain the safety of your personal information. Your data is contained behind secured networks and is only accessible by a limited number of persons who have special access rights to such systems.'
            ),

            _buildSectionTitle('4', 'Contact Us'),
            _buildSectionContent(
              'If you have any questions regarding this privacy policy, you may contact us using the information below:\n\n'
              '📧 support@accessories-app.com'
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  
  Widget _buildSectionTitle(String number, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          color: Colors.black54,
        ),
      ),
    );
  }
}