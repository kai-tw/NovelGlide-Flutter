import 'package:flutter/material.dart';

class DiscoverBrowserIcon extends StatelessWidget {
  const DiscoverBrowserIcon({
    super.key,
    this.isOutlined = false,
    this.color,
  });

  const DiscoverBrowserIcon.outlined({
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
