import 'package:flutter/material.dart';

class CommonDraggableScrollableSheet extends StatelessWidget {
  const CommonDraggableScrollableSheet({super.key, this.padding = 24.0, required this.builder});

  final double padding;
  final Widget Function(BuildContext context, ScrollController controller) builder;
  static double maxHeightRatio = 1.0;
  static bool showDragHandle = true;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.25,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.6],
      builder: (context, controller) => SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: builder(context, controller),
        ),
      ),
    );
  }
}
