import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({this.onPressed, super.key, this.popValue});

  final dynamic popValue;
  final void Function()? onPressed;

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
        semanticLabel: appLocalizations.accessibilityBackButton,
      ),
    );
  }
}
