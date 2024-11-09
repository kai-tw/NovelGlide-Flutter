part of '../../backup_manager_google_drive.dart';

class _ProcessAllLibraryTile extends StatelessWidget {
  const _ProcessAllLibraryTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_ProcessCubit, _ProcessState>(
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
          case _ProcessStep.zip:
            return ListTile(
              leading: const Icon(Icons.folder_zip_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: CircularProgressIndicator(
                value: state.libraryProgress,
              ),
            );

          case _ProcessStep.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.unzip:
            return ListTile(
              leading: const Icon(Icons.folder_zip_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: CircularProgressIndicator(
                value: state.libraryProgress,
              ),
            );

          case _ProcessStep.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.backupManagerLabelLibrary),
            );

          case _ProcessStep.error:
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
