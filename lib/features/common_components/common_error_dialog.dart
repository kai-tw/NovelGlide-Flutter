import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonErrorDialog extends StatelessWidget {
  final String content;

  const CommonErrorDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      icon: const Icon(Icons.error_outline_rounded),
      iconColor: Theme.of(context).colorScheme.error,
      title: Text(appLocalizations.exceptionUnknownError),
      content: Text(content),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          label: Text(appLocalizations.generalClose),
        ),
      ],
    );
  }
}
