part of '../backup_manager_process_all_dialog.dart';

class _LibraryTile extends StatelessWidget {
  const _LibraryTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ProcessAllDialogCubit,
        BackupManagerProcessAllDialogState>(
      buildWhen: (previous, current) =>
          previous.libraryStep != current.libraryStep ||
          previous.libraryProgress != current.libraryProgress,
      builder: (context, state) {
        // Disable state.
        if (!state.isLibraryRunning) {
          return ListTile(
            leading: const Icon(Icons.shelves),
            title: Text(appLocalizations.backupManagerLabelLibrary),
            enabled: false,
          );
        }

        switch (state.libraryStep) {
          case BackupManagerProcessStepCode.zip:
            return ListTile(
              leading: const Icon(Icons.folder_zip_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: CircularProgressIndicator(
                value: state.libraryProgress,
              ),
            );

          case BackupManagerProcessStepCode.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.unzip:
            return ListTile(
              leading: const Icon(Icons.folder_zip_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: CircularProgressIndicator(
                value: state.libraryProgress,
              ),
            );

          case BackupManagerProcessStepCode.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: const CircularProgressIndicator(),
            );

          case BackupManagerProcessStepCode.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
            );

          case BackupManagerProcessStepCode.error:
            return ListTile(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              leading: const Icon(Icons.error_outline_rounded),
              title: Text(appLocalizations.backupManagerLabelLibrary),
            );

          default:
            return ListTile(
              leading: const Icon(Icons.shelves),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: const CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
