// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button_with_icon.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/custom_container_screen.dart';
import 'package:graduation_project_nti/features/profile/presentation/widgets/custom_container.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messsageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: 'Help Center',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How can we help?",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 10),
              Text(
                "Our team is here to assist you with your orders and accessory inquiries",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      icon: Icons.call,
                      text: 'Call Us',
                      hintText: '+1 (800) 555-0123',
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomContainer(
                      icon: Icons.email,
                      text: 'Email Us',
                      hintText: 'support@brand.com',
                      color: Color(0xff3B82F6),
                      backgroundColor: Color(0xff3B82F6).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Send a Message",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Full Name',
                      hintText: 'Jane Doe',
                      controller: fullnameController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Email Address',
                      hintText: 'jane@example.com',
                      controller: emailController,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Message',
                      hintText: 'How can we help you today?',
                      controller: messsageController,
                      maxLines: 4,
                    ),
                    SizedBox(height: 25),
                    CustomElevatedButtonWithIcon(
                      text: 'Send Message',
                      icon: Icons.send,
                      onPressed: () {},
                      textColor: Theme.of(context).colorScheme.primary,
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
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

                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FAQ',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CustomContainerScreen(text: 'Where is my order?'),
                    SizedBox(height: 16),
                    CustomContainerScreen(text: 'What is the return policy?'),
                    SizedBox(height: 16),
                    CustomContainerScreen(text: 'Do you ship internationally?'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
