import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/presentation/screens/product_details_screen.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({super.key});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  int? isSelected;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(childCount: 10, (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
              );
            },
            child: Card(
              color: AppColors.backgroundColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/test/test1.png',
                            height: height * 0.24,
                            width: width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (isSelected == index) {
                                  isSelected = null;
                                } else {
                                  isSelected = index;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.favorite_border,
                              color: isSelected == index
                                  ? Colors.red
                                  : AppColors.hintTextColor,
                              size: 18,
                            ),
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(25, 25),
                              backgroundColor: AppColors.backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    CustomText(
                      overflow: TextOverflow.ellipsis,
                      text: 'Minimalist Chain',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    CustomText(
                      text: 'Gold Plated',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.hintTextColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: '\$45.00',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: AppColors.backgroundColor,
                            size: 18,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(25, 25),
                            backgroundColor: AppColors.textColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.6,
        ),
      ),
    );
  }
}
