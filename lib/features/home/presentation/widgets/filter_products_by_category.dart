import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class FilterProductsByCategory extends StatefulWidget {
  const FilterProductsByCategory({super.key});

  @override
  State<FilterProductsByCategory> createState() =>
      _FilterProductsByCategoryState();
}

class _FilterProductsByCategoryState extends State<FilterProductsByCategory> {
  final List<String> categories = [
    "All",
    "New In",
    "Best Sellers",
    "Sale",
    "Best Sellers",
    "Sale",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(color: Color(0xffF8F6F6)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.backgroundColor,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey.shade400,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomText(
                    text: categories[index],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.backgroundColor
                        : AppColors.textColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
