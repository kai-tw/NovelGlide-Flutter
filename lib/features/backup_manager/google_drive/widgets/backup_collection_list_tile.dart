part of '../backup_manager_google_drive.dart';

class _BackupCollectionListTile extends StatelessWidget {
  const _BackupCollectionListTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(appLocalizations.backupManagerLabelCollection),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BackupCollectionButton(),
          _RestoreCollectionButton(),
          _DeleteCollectionButton(),
        ],
      ),
    );
  }
}
