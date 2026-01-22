import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/constants/app_themes.dart';
import 'package:graduation_project_nti/core/theme/theme_cubit.dart';
import 'package:graduation_project_nti/core/theme/theme_state.dart';
import 'package:graduation_project_nti/features/splash/presentation/screens/splash_screen.dart';

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
            debugShowCheckedModeBanner: false,
            title: 'Graduation Project NTI',
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
