import 'package:flutter/material.dart';

class CustomIndicatorWidget extends StatelessWidget {
  const CustomIndicatorWidget({super.key, required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(50),
        minHeight: 6,
        value: value,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primary,
        ),
        semanticsLabel: 'Linear progress indicator',
        semanticsValue: '50%',
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.2),
      ),
    );
  }
}
