# 🎨 Theme Implementation Guide - Light & Dark Mode

This guide explains how to use the theme system in this Flutter application.

## 📁 File Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_themes.dart          # Theme definitions (Light & Dark)
│   ├── theme/
│   │   ├── theme_cubit.dart         # Theme state management
│   │   └── theme_state.dart         # Theme state model
│   └── shared_widgets/
│       └── themed_example_widget.dart # Example themed widgets
├── features/
│   └── profile/
│       └── presentation/
│           └── widgets/
│               └── custom_settings_tile.dart # Theme toggle switch
└── main.dart                         # App entry point with BlocProvider
```

## 🚀 Quick Start

### 1. Main.dart Setup

The app is already configured with `ThemeCubit` in `main.dart`:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/constants/app_themes.dart';
import 'package:graduation_project_nti/core/theme/theme_cubit.dart';
import 'package:graduation_project_nti/core/theme/theme_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GraduationProjectNti());
}

class GraduationProjectNti extends StatelessWidget {
  const GraduationProjectNti({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeState.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
```

### 2. Toggle Theme in Profile Screen

The theme toggle is already implemented in the Profile screen under "App Settings" → "Dark Mode".

The switch automatically:
- ✅ Toggles between light and dark mode
- ✅ Saves preference to SharedPreferences
- ✅ Shows a SnackBar notification
- ✅ Persists across app restarts

## 💡 How to Use Theming in Your Widgets

### Method 1: Using Theme.of(context) (Recommended)

```dart
Widget build(BuildContext context) {
  return Container(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Text(
      'Hello World',
      style: Theme.of(context).textTheme.titleLarge,
    ),
  );
}
```

### Method 2: Using BlocBuilder for Theme-Aware Widgets

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/theme/theme_cubit.dart';
import 'package:graduation_project_nti/core/theme/theme_state.dart';

Widget build(BuildContext context) {
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) {
      final isDark = themeState.isDarkMode;
      
      return Container(
        color: isDark ? Colors.black : Colors.white,
        child: Text(
          isDark ? 'Dark Mode Active' : 'Light Mode Active',
        ),
      );
    },
  );
}
```

### Method 3: Programmatically Toggle Theme

```dart
// Toggle theme
context.read<ThemeCubit>().toggleTheme();

// Set specific theme
context.read<ThemeCubit>().setLightTheme();
context.read<ThemeCubit>().setDarkTheme();
```

## 🎨 Available Theme Properties

### Colors
```dart
// Primary color
Theme.of(context).colorScheme.primary

// Background colors
Theme.of(context).scaffoldBackgroundColor
Theme.of(context).cardColor
Theme.of(context).colorScheme.surface

// Text colors
Theme.of(context).textTheme.bodyLarge?.color
Theme.of(context).textTheme.bodySmall?.color
```

### Text Styles
```dart
// Large titles
Theme.of(context).textTheme.displayLarge
Theme.of(context).textTheme.displayMedium
Theme.of(context).textTheme.displaySmall

// Headlines
Theme.of(context).textTheme.headlineMedium

// Titles
Theme.of(context).textTheme.titleLarge

// Body text
Theme.of(context).textTheme.bodyLarge
Theme.of(context).textTheme.bodyMedium
Theme.of(context).textTheme.bodySmall
```

## 📝 Example Widgets

Check `lib/core/shared_widgets/themed_example_widget.dart` for complete examples:

1. **ThemedExampleWidget** - Full example with all theme features
2. **ThemedCard** - Simple themed card
3. **ThemedTextField** - Themed text input

## ✅ Features

- ✅ Light and Dark mode support
- ✅ Persistent theme selection (SharedPreferences)
- ✅ Toggle switch in Profile screen
- ✅ SnackBar feedback on theme change
- ✅ Automatic theme restoration on app restart
- ✅ Material 3 design
- ✅ Null safety compatible
- ✅ Flutter 3.x+ compatible

## 🔧 Customization

To customize colors, edit `lib/core/constants/app_themes.dart`:

```dart
class AppThemes {
  // Light Theme Colors
  static const Color lightPrimaryColor = Color(0xFFEC3713);
  static const Color lightBackgroundColor = Colors.white;
  // ... more colors

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFFEC3713);
  static const Color darkBackgroundColor = Color(0xFF121212);
  // ... more colors
}
```

## 📱 Testing

1. Run the app
2. Navigate to Profile screen
3. Toggle "Dark Mode" switch
4. Observe theme change with SnackBar notification
5. Restart app - theme should persist

## 🐛 Troubleshooting

**Theme not changing?**
- Make sure `BlocProvider<ThemeCubit>` is at the root of your app
- Check that you're using `Theme.of(context)` instead of hardcoded colors

**Theme not persisting?**
- Ensure `WidgetsFlutterBinding.ensureInitialized()` is called in `main()`
- Check SharedPreferences permissions

**Colors not updating?**
- Replace hardcoded `AppColors` with `Theme.of(context)` properties
- Use `BlocBuilder` for widgets that need to react to theme changes

---

Made with ❤️ for Graduation Project NTI

