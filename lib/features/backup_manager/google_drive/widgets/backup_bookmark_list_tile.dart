part of '../backup_manager_google_drive.dart';

class _BackupBookmarkListTile extends StatelessWidget {
  const _BackupBookmarkListTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(appLocalizations.backupManagerLabelBookmark),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BackupBookmarkButton(),
          _RestoreBookmarkButton(),
          _DeleteBookmarkButton(),
        ],
      ),
    );
  }
}
