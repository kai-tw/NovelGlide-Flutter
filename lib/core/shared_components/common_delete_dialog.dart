import 'package:flutter/material.dart';

import '../../generated/i18n/app_localizations.dart';

class CommonDeleteDialog extends StatelessWidget {
  const CommonDeleteDialog({
    super.key,
    this.onDelete,
    this.title,
    this.content,
    this.deleteIcon,
    this.deleteLabel,
  });

  final String? title;
  final String? content;
  final IconData? deleteIcon;
  final String? deleteLabel;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(title ?? appLocalizations.dialogDeleteTitle),
      content: Text(content ?? appLocalizations.dialogDeleteContent),
      actions: <Widget>[
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
            iconColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          icon: Icon(deleteIcon ?? Icons.delete_rounded),
          label: Text(deleteLabel ?? appLocalizations.generalDelete),
        ),
      ],
    );
  }
}
