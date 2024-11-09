import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonSuccessDialog extends StatelessWidget {
  final String? title;
  final String? content;

  // Constructor for the dialog, requiring a content string
  const CommonSuccessDialog({
    super.key,
    this.title,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return AlertDialog(
      icon: Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: title == null && content == null ? 50.0 : null,
      ),
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
      actions: [
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          label: Text(appLocalizations.generalClose),
        ),
      ],
    );
  }
}
