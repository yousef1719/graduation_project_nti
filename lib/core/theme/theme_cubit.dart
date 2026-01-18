import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

/// Theme Cubit - Manages app theme state
class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'app_theme_mode';

  ThemeCubit() : super(ThemeState.initial()) {
    _loadTheme();
  }

  /// Load saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themeKey) ?? false;
      
      emit(ThemeState(
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        isDarkMode: isDark,
      ));
    } catch (e) {
      // If error, keep default light theme
      emit(ThemeState.initial());
    }
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    try {
      final newIsDark = !state.isDarkMode;
      
      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, newIsDark);
      
      // Update state
      emit(ThemeState(
        themeMode: newIsDark ? ThemeMode.dark : ThemeMode.light,
        isDarkMode: newIsDark,
      ));
    } catch (e) {
      // Handle error silently or emit error state if needed
      debugPrint('Error toggling theme: $e');
    }
  }

  /// Set specific theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      final isDark = mode == ThemeMode.dark;
      
      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDark);
      
      // Update state
      emit(ThemeState(
        themeMode: mode,
        isDarkMode: isDark,
      ));
    } catch (e) {
      debugPrint('Error setting theme mode: $e');
    }
  }

  /// Set light theme
  Future<void> setLightTheme() async {
    await setThemeMode(ThemeMode.light);
  }

  /// Set dark theme
  Future<void> setDarkTheme() async {
    await setThemeMode(ThemeMode.dark);
  }
}

