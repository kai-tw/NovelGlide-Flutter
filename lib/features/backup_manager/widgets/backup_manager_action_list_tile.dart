import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dialog/backup_manager_loading_dialog.dart';
import '../dialog/backup_manager_success_dialog.dart';

class BackupManagerActionListTile extends StatelessWidget {
  final Future<Object?> Function() future;
  final IconData iconData;
  final String titleLabel;
  final String successLabel;
  final bool enabled;
  final void Function()? onComplete;

  const BackupManagerActionListTile({
    super.key,
    required this.future,
    required this.iconData,
    required this.titleLabel,
    required this.successLabel,
    required this.enabled,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    // Access localized strings
    final appLocalizations = AppLocalizations.of(context);

    return ListTile(
      onTap: () async {
        // Show a dialog while the future is being resolved
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return FutureBuilder<Object?>(
              future: future(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loading dialog while waiting
                  return const BackupManagerLoadingDialog();
                } else if (snapshot.hasError) {
                  // Handle error state
                  return AlertDialog(
                    title: Text(appLocalizations?.exceptionUnknownError ?? 'Error'),
                    content: Text(snapshot.error.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(appLocalizations?.generalClose ?? 'Close'),
                      ),
                    ],
                  );
                } else {
                  // Show success dialog if data is available
                  return BackupManagerSuccessDialog(content: successLabel);
                }
              },
            );
          },
        );

        // Call onComplete callback if provided
        if (onComplete != null) {
          onComplete!();
        }
      },
      leading: Icon(iconData),
      title: Text(titleLabel),
      enabled: enabled,
    );
  }
}
