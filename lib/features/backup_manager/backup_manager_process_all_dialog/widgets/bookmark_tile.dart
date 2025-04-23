part of '../backup_manager_process_all_dialog.dart';

class _BookmarkTile extends StatelessWidget {
  const _BookmarkTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ProcessAllDialogCubit,
        BackupManagerProcessAllDialogState>(
      buildWhen: (BackupManagerProcessAllDialogState previous,
              BackupManagerProcessAllDialogState current) =>
          previous.isBookmarkRunning != current.isBookmarkRunning ||
          previous.bookmarkStep != current.bookmarkStep ||
          previous.bookmarkProgress != current.bookmarkProgress,
      builder:
          (BuildContext context, BackupManagerProcessAllDialogState state) {
        // Disable state.
        if (!state.isBookmarkRunning) {
          return ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: Text(appLocalizations.backupManagerLabelBookmark),
            enabled: false,
          );
        }

        switch (state.bookmarkStep) {
          case BackupManagerProcessStepCode.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
            );

          case BackupManagerProcessStepCode.error:
            return ListTile(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              leading: const Icon(Icons.error_outline_rounded),
              title: Text(appLocalizations.backupManagerLabelBookmark),
            );

          default:
            return ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: Text(appLocalizations.backupManagerLabelBookmark),
              trailing: const CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
