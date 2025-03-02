import 'package:flutter/material.dart';

import '../../generated/i18n/app_localizations.dart';

class CommonErrorDialog extends StatelessWidget {
  final String? title;
  final String? content;

  const CommonErrorDialog({super.key, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      icon: const Icon(Icons.error_outline_rounded),
      iconColor: Theme.of(context).colorScheme.error,
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
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
