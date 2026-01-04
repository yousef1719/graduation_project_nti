// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/home/data/models/category_model.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({super.key});

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  final List<CategoryModel> items = [
    CategoryModel(name: 'Jewelry', image: 'assets/images/test/jewelry.png'),
    CategoryModel(name: 'Bags', image: 'assets/images/test/bags.png'),
    CategoryModel(name: 'Scarves', image: 'assets/images/test/scarves.png'),
    CategoryModel(name: 'Eye Wear', image: 'assets/images/test/eye_wear.png'),
    CategoryModel(name: 'Watches', image: 'assets/images/test/watches.png'),
  ];
  int isSeleceted = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Category',
            fontSize: 18,
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSeleceted = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSeleceted == index
                                  ? AppColors.primaryColor.withOpacity(0.5)
                                  : Color(0xffE5E7EB),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(items[index].image),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      CustomText(
                        text: items[index].name,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
