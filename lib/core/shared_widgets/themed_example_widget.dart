// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/theme/theme_cubit.dart';
import 'package:graduation_project_nti/core/theme/theme_state.dart';

class ThemedExampleWidget extends StatelessWidget {
  const ThemedExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState.isDarkMode;
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Themed Widget Example',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'This widget automatically adapts to light and dark themes.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                child: Text(
                  isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Current mode: ${isDark ? "Dark" : "Light"}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Example of a simple themed card
class ThemedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const ThemedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card automatically uses theme.cardColor
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        onTap: onTap,
      ),
    );
  }
}

/// Example of themed text field
class ThemedTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;

  const ThemedTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // TextField automatically uses theme.inputDecorationTheme
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        // You can override specific properties if needed
        prefixIcon: Icon(
          Icons.edit,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      // Text color automatically adapts to theme
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
