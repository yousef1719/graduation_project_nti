import 'package:flutter/material.dart';

/// Theme State
class ThemeState {
  final ThemeMode themeMode;
  final bool isDarkMode;

  const ThemeState({
    required this.themeMode,
    required this.isDarkMode,
  });

  factory ThemeState.initial() {
    return const ThemeState(
      themeMode: ThemeMode.light,
      isDarkMode: false,
    );
  }

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isDarkMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

