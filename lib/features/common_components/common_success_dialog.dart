import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonSuccessDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;

  // Constructor for the dialog, requiring a content string
  const CommonSuccessDialog({
    super.key,
    required this.title,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return AlertDialog(
      icon: const Icon(
        Icons.check_rounded,
        color: Colors.green,
        // size: 50.0,
      ),
      title: title,
      content: content,
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
