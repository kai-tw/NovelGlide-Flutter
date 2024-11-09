part of '../../backup_manager_google_drive.dart';

class _ProcessAllCollectionTile extends StatelessWidget {
  const _ProcessAllCollectionTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_ProcessCubit, _ProcessState>(
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
          case _ProcessStep.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.backupManagerLabelCollection),
            );

          case _ProcessStep.error:
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
