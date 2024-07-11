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
        Navigator.of(context).pop(popValue);

        if (onPressed != null) {
          onPressed!();
        }
      },
      icon: Semantics(
        label: appLocalizations.accessibilityBackButton,
        button: true,
        enabled: true,
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}