import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackupManagerSuccessDialog extends StatelessWidget {
  final String content;

  // Constructor for the dialog, requiring a content string
  const BackupManagerSuccessDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    // Access localized strings, with a fallback if null
    final appLocalizations = AppLocalizations.of(context);

    return AlertDialog(
      // Icon indicating success
      icon: const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 50.0,
      ),
      // Display the content text in the center
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18.0),
      ),
      actions: [
        // Close button for the dialog
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(), // Close the dialog
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          // Localized text for the button
          child: Text(appLocalizations?.generalClose ?? 'Close'),
        ),
      ],
      // Center the actions horizontally
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
