import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonDeleteDialog extends StatelessWidget {
  final void Function()? onDelete;

  const CommonDeleteDialog({super.key, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(appLocalizations.dialogDeleteTitle),
      content: Text(appLocalizations.dialogDeleteContent),
      actions: [
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_rounded),
          label: Text(appLocalizations.generalCancel),
        ),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            onDelete?.call();
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          icon: const Icon(Icons.delete_rounded),
          label: Text(appLocalizations.generalDelete),
        ),
      ],
    );
  }
}
