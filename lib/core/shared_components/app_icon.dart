import 'dart:math' show min;

import 'package:flutter/material.dart';

import '../../generated/i18n/app_localizations.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, this.margin, this.width, this.height});

  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalizations.of(context)!.accessibilityAppIcon,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double widthValue = width ?? constraints.maxWidth;
          final double heightValue = height ?? constraints.maxHeight;
          final double borderRadius = min(widthValue, heightValue) * 0.24;

          return Container(
            margin: margin,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset('assets/images/app_icon.png'),
          );
        },
      ),
    );
  }
}
