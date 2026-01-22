// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_snack_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/core/theme/theme_cubit.dart';
import 'package:graduation_project_nti/core/theme/theme_state.dart';
import 'package:graduation_project_nti/features/profile/data/models/settings_item_model.dart';

class CustomSettingsTile extends StatelessWidget {
  final SettingsItemModel item;

  const CustomSettingsTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState.isDarkMode;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                  : const Color(0xffFEEBE8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: item.subtitle.isEmpty
              ? CustomText(
                  text: item.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: item.title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    CustomText(
                      text: item.subtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ],
                ),
          trailing: item.hasSwitch
              ? Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: isDark,
                    onChanged: (value) async {
                      await context.read<ThemeCubit>().toggleTheme();

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.show(
                            message: value
                                ? '🌙 Dark mode enabled'
                                : '☀️ Light mode enabled',
                            backgroundColor: Colors.green.shade700,
                          ),
                        );
                      }
                    },
                    activeColor: Colors.green,
                    trackColor: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.5),
                  ),
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          onTap: item.onTap,
        );
      },
    );
  }
}
