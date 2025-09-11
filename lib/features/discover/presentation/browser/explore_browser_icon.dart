import 'package:flutter/material.dart';

class ExploreBrowserIcon extends StatelessWidget {
  const ExploreBrowserIcon({
    super.key,
    this.isOutlined = false,
    this.color,
  });

  const ExploreBrowserIcon.outlined({
    super.key,
    this.color,
  }) : isOutlined = true;

  final bool isOutlined;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isOutlined ? Icons.explore_outlined : Icons.explore,
      color: color,
    );
  }
}
