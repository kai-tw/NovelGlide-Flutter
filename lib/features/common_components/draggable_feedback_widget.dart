import 'package:flutter/material.dart';

class DraggableFeedbackWidget extends StatelessWidget {
  const DraggableFeedbackWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: 8.0,
            spreadRadius: 0.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
