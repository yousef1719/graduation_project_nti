import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/cart/presentation/widgets/promo_text_field.dart';

class PromoCodeWidget extends StatelessWidget {
  const PromoCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController promoController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Promo Code",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xff374151),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: PromoTextField(controller: promoController)),
            const SizedBox(width: 10),
            SizedBox(
              height: 44,
              width: 85,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff111827),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
