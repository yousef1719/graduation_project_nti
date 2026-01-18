import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onPressedLeading,
    this.title,
    this.actions,
    this.centerTitle,
    this.leading,
    this.automaticallyImplyLeading,
  });
  final Widget? leading;
  final void Function()? onPressedLeading;
  final List<Widget>? actions;
  final String? title;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: centerTitle ?? true,
      title: CustomText(
        text: title ?? '',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      leading:
          leading ??
          IconButton(
            onPressed: onPressedLeading ?? () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
      actions: actions,
    );
  }
}
