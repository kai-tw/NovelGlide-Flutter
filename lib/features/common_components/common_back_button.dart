import 'package:flutter/material.dart';

import '../../generated/i18n/app_localizations.dart';

class CommonBackButton extends StatelessWidget {
  final dynamic popValue;
  final void Function()? onPressed;
  final IconData iconData;
  final ButtonStyle? style;

  const CommonBackButton({
    this.onPressed,
    super.key,
    this.popValue,
    this.style,
    this.iconData = Icons.arrow_back_ios_new_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: onPressed ?? () => Navigator.of(context).pop(popValue),
      style: style,
      icon: Icon(
        iconData,
        semanticLabel: appLocalizations.accessibilityBackButton,
      ),
    );
  }
}
