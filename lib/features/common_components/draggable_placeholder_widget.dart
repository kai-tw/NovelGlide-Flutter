import 'package:flutter/material.dart';

class DraggablePlaceholderWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  const DraggablePlaceholderWidget({super.key, required this.child, this.width, this.height, this.padding});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        color: Theme.of(context).colorScheme.surface,
        child: child,
      ),
    );
  }
}
