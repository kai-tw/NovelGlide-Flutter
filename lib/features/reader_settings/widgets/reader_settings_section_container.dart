import 'package:flutter/material.dart';

class ReaderSettingsSectionContainer extends StatelessWidget {
  const ReaderSettingsSectionContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}