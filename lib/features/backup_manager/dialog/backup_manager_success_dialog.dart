import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackupManagerSuccessDialog extends StatelessWidget {
  final String content;

  const BackupManagerSuccessDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      icon: const Icon(Icons.check_rounded, color: Colors.green, size: 50.0),
      content: Text(content, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18.0)),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(appLocalizations.generalClose),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}