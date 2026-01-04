// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button_with_icon.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text_button.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, int itemindex, int pageViewIndex) => Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset('assets/images/test/test_banner.png'),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextButton(
                    text: 'Summer Sale',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(90, 25),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  CustomText(
                    text: 'Up to 50% Off',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                  CustomText(
                    text: 'Premium accessories for the season.',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.backgroundColor,
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButtonWithIcon(),
                ],
              ),
            ),
          ),
        ],
      ),
      options: CarouselOptions(
        height: height * 0.27,
        viewportFraction: 0.9,
        aspectRatio: 1,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 5),
        autoPlayInterval: Duration(seconds: 10),
        enlargeCenterPage: true,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
