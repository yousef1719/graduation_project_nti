import 'package:flutter/material.dart';

class PromoTextField extends StatelessWidget {
  const PromoTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: Theme.of(context).colorScheme.primary,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: "Enter code",
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          prefixIcon: Icon(
            Icons.local_offer_outlined,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
