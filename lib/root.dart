// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/cart/presentation/screens/cart_screen.dart';
import 'package:graduation_project_nti/features/home/presentation/screens/home_screen.dart';
import 'package:graduation_project_nti/features/products/presentation/screens/product_screen.dart';
import 'package:graduation_project_nti/features/profile/presentation/screens/profile_screen.dart';
import 'package:liquid_glass_navbar/liquid_glass_navbar.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    HomeScreen(),
    ProductScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return LiquidGlassNavBar(
      currentIndex: _currentIndex,
      onPageChanged: (index) {
        setState(() => _currentIndex = index);
      },
      pages: _screens,
      items: [
        LiquidGlassNavItem(icon: CupertinoIcons.house, label: "Home"),
        LiquidGlassNavItem(icon: CupertinoIcons.bag, label: "Products"),
        LiquidGlassNavItem(icon: CupertinoIcons.cart, label: "Cart"),
        LiquidGlassNavItem(icon: CupertinoIcons.person, label: "Profile"),
      ],
      horizontalPadding: 10,
      bubbleWidth: 90,
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor.withOpacity(0.8),
      itemColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
      bubbleColor: Theme.of(context).scaffoldBackgroundColor,
      blurStrength: 4,
      showBubble: true,
      enableDragging: true,
      borderRadius: 30,
      elevation: 5,
      iconSize: 20,
      fontSize: 12,
      animationDuration: 100,
    );
  }
}
