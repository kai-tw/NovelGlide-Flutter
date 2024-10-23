import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackupManagerErrorDialog extends StatelessWidget {
  final String content;

  const BackupManagerErrorDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(appLocalizations.exceptionUnknownError),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.generalClose),
        ),
      ],
    );
  }
}
