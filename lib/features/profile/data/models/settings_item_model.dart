import 'package:flutter/material.dart';

class SettingsItemModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hasSwitch;
  final VoidCallback? onTap;

  SettingsItemModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hasSwitch = false,
    this.onTap,
  });
}
