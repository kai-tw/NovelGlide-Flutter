import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../dialog/backup_manager_error_dialog.dart';
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
    return ListTile(
      onTap: () => _onTap(context),
      leading: Icon(iconData),
      title: Text(titleLabel),
      enabled: enabled,
    );
  }

  Future<void> _onTap(BuildContext context) async {
    // Show a dialog while the future is being resolved
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return FutureBuilder<Object?>(
          future: future(),
          builder: _buildDialog,
        );
      },
    );

    // Call onComplete callback if provided
    if (onComplete != null) {
      onComplete!();
    }
  }

  Widget _buildDialog(BuildContext context, AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      // Handle error state
      // Record the error log
      final logger = Logger();
      logger.e(snapshot.error);
      logger.close();

      // Show the error dialog.
      return BackupManagerErrorDialog(content: snapshot.error.toString());
    } else {
      switch (snapshot.connectionState) {
        case ConnectionState.done:
          // Operation done. Show success dialog.
          return BackupManagerSuccessDialog(content: successLabel);

        default:
          // Show loading dialog while waiting
          return const BackupManagerLoadingDialog();
      }
    }
  }
}
