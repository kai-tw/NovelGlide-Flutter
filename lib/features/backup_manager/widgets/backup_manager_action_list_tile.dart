import 'package:flutter/material.dart';

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
      onTap: () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return FutureBuilder(
              future: future(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BackupManagerSuccessDialog(content: successLabel);
                } else {
                  return const BackupManagerLoadingDialog();
                }
              },
            );
          },
        );

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
