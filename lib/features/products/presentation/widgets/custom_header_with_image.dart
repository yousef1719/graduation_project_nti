// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';

class CustomHeaderWithImage extends StatelessWidget {
  const CustomHeaderWithImage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      expandedHeight: height * 0.5,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/test/test1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 28,
                right: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.heart),
                  style: IconButton.styleFrom(
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(30, 30),
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 28,
                right: 55,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.cart),
                  style: IconButton.styleFrom(
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(30, 30),
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 28,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(CupertinoIcons.back, color: AppColors.textColor),
                  style: IconButton.styleFrom(
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(30, 30),
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -1,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: Offset(0, -10),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -1,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: Container(
                    height: 40,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
