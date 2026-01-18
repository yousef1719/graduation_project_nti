import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/models/color_variant.dart';

class ProductColorsSelectorSection extends StatefulWidget {
  const ProductColorsSelectorSection({super.key});

  @override
  State<ProductColorsSelectorSection> createState() =>
      _ProductColorsSelectorSectionState();
}

class _ProductColorsSelectorSectionState
    extends State<ProductColorsSelectorSection> {
  int selectedIndex = 0;

  final List<ColorVariant> variants = [
    ColorVariant(color: Color(0xff8B4513)),
    ColorVariant(color: Colors.black),
    ColorVariant(color: Color(0xffE5D0B1)),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'Color', fontSize: 18, fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        Row(
          children: List.generate(variants.length, (index) {
            final variant = variants[index];
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Tooltip(
                message: 'Color',
                child: Container(
                  margin: const EdgeInsets.only(right: 3),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 33,
                      height: 33,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: variant.color,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
