import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.backgroundColor,
            ),
          ),
          title: Text(
            "Help Center",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  "How can we help?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 7.5),
                Text(
                  "Our team is here to assist you with your orders and accessory inquiries",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintTextColor,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: CustomContainer(
                        icon: Icons.call,
                        text: 'Call Us',
                        hintText: '+1 (800) 555-0123',
                        color: AppColors.primaryColor,
                        backgroundColor: Color(0xffEC3713).withOpacity(0.1),
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
                SizedBox(height: 32),
                Container(
                  width: 400,
                  height: 498,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send a Message",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
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
                          labelText: 'MESSAGE',
                          hintText: 'How can we help you today?',
                          controller: messsageController,
                          maxLines: 4,
                        ),
                        SizedBox(height: 16),
                        CustomElevatedButtonWithIcon(
                          text: 'Send Message',
                          icon: Icons.send,
                          textColor: AppColors.backgroundColor,
                          iconColor: AppColors.backgroundColor,
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'FAQ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor,
                              ),
                            ),
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        CustomContainerScreen(text: 'Where is my order?'),
                        SizedBox(height: 16),
                        CustomContainerScreen(
                          text: 'What is the return policy?',
                        ),
                        SizedBox(height: 16),
                        CustomContainerScreen(
                          text: 'Do you ship internationally?',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
