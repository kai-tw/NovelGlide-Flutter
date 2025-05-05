import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 24.0,
          ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: child,
    );
  }
}
