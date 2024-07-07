import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppIcon extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const AppIcon({super.key, this.margin, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalizations.of(context)!.accessibilityAppIcon,
      child: LayoutBuilder(
          builder: (context, constraints) {
            final double widthValue = width ?? constraints.maxWidth;
            final double heightValue = height ?? constraints.maxHeight;
            final double borderRadius = min(widthValue, heightValue) * 0.24;

            return Container(
              margin: margin,
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset("assets/images/app_icon.png"),
            );
          }
      ),
    );
  }
}
