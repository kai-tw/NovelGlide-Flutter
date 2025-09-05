import 'package:flutter/material.dart';

class SharedBottomContainer extends StatelessWidget {
  const SharedBottomContainer({
    super.key,
    this.margin,
    this.padding,
    required this.child,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8.0),
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
