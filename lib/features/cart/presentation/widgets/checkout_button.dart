import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CheckoutButton extends StatelessWidget {
  final double total;

  const CheckoutButton({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Checkout',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.backgroundColor,
              ),

              Row(
                children: [
                  CustomText(
                    text: '\$${total.toStringAsFixed(2)}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
