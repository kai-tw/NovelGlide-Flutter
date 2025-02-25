part of '../backup_manager_process_all_dialog.dart';

class _CollectionTile extends StatelessWidget {
  const _CollectionTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ProcessAllDialogCubit,
        BackupManagerProcessAllDialogState>(
      buildWhen: (previous, current) =>
          previous.collectionStep != current.collectionStep ||
          previous.collectionProgress != current.collectionProgress,
      builder: (context, state) {
        // Disable state.
        if (!state.isCollectionRunning) {
          return ListTile(
            leading: const Icon(Icons.collections_bookmark_outlined),
            title: Text(appLocalizations.backupManagerLabelCollection),
            enabled: false,
          );
        }

        switch (state.collectionStep) {
          case BackupManagerProcessStepCode.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
            );

          case BackupManagerProcessStepCode.error:
            return ListTile(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              leading: const Icon(Icons.error_outline_rounded),
              title: Text(appLocalizations.backupManagerLabelCollection),
            );

          default:
            return ListTile(
              leading: const Icon(Icons.collections_bookmark_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
              trailing: const CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
