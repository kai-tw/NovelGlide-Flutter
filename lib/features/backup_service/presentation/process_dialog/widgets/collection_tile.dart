part of '../backup_service_process_dialog.dart';

class _CollectionTile extends StatelessWidget {
  const _CollectionTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BackupServiceProcessCollectionCubit,
        BackupServiceProcessItemState>(
      builder: (BuildContext context, BackupServiceProcessItemState state) {
        switch (state.step) {
          case BackupServiceProcessStepCode.disabled:
            return ListTile(
              leading: const Icon(Icons.collections_bookmark_outlined),
              title: Text(appLocalizations.generalCollection(2)),
              enabled: false,
            );

          case BackupServiceProcessStepCode.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.generalCollection(2)),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupServiceProcessStepCode.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.generalCollection(2)),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupServiceProcessStepCode.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.generalCollection(2)),
              trailing: const CircularProgressIndicator(),
            );

          case BackupServiceProcessStepCode.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.generalCollection(2)),
            );

          case BackupServiceProcessStepCode.error:
            return ListTile(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              leading: const Icon(Icons.error_outline_rounded),
              title: Text(appLocalizations.generalCollection(2)),
            );

          default:
            return ListTile(
              leading: const Icon(Icons.collections_bookmark_outlined),
              title: Text(appLocalizations.generalCollection(2)),
              trailing: const CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
