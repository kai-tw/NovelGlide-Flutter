import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonBackButton extends StatelessWidget {
  final dynamic popValue;
  final void Function()? onPressed;
  final Color? color;

  const CommonBackButton({this.onPressed, super.key, this.popValue, this.color});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.of(context).pop(popValue);
        }
      },
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: color,
        semanticLabel: appLocalizations.accessibilityBackButton,
      ),
    );
  }
}
