import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonFailedDialog extends StatelessWidget {
  const CommonFailedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error_outline_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.error,
      content: Text(
        AppLocalizations.of(context)!.add_failed,
        textAlign: TextAlign.center,
      ),
    );
  }
}