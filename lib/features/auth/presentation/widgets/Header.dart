import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff64748B),
          ),
        ),
      ],
    );
  }
}
