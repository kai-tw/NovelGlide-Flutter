import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonDialogCloseButton extends StatelessWidget {
  const CommonDialogCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(AppLocalizations.of(context)!.close),
    );
  }
}