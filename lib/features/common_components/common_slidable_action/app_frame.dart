import 'package:flutter/material.dart';

class AppFrame extends StatelessWidget {
  const AppFrame({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onSurface,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        clipBehavior: Clip.hardEdge,
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}