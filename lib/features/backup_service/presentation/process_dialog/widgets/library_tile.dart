part of '../backup_service_process_dialog.dart';

class _LibraryTile extends StatelessWidget {
  const _LibraryTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BackupServiceProcessLibraryCubit,
        BackupServiceProcessItemState>(
      builder: (BuildContext context, BackupServiceProcessItemState state) {
        switch (state.step) {
          case BackupServiceProcessStepCode.disabled:
            return ListTile(
              leading: const Icon(Icons.shelves),
              title: Text(appLocalizations.generalBookshelf),
              enabled: false,
            );

          case BackupServiceProcessStepCode.zip:
            return ListTile(
              leading: const Icon(Icons.folder_zip_outlined),
              title: Text(appLocalizations.generalBookshelf),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupServiceProcessStepCode.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.generalBookshelf),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupServiceProcessStepCode.unzip:
            return ListTile(
              leading: const Icon(Icons.folder_zip_outlined),
              title: Text(appLocalizations.generalBookshelf),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupServiceProcessStepCode.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.generalBookshelf),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupServiceProcessStepCode.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.generalBookshelf),
              trailing: const CircularProgressIndicator(),
            );

          case BackupServiceProcessStepCode.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.generalBookshelf),
            );

          case BackupServiceProcessStepCode.error:
            return ListTile(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              leading: const Icon(Icons.error_outline_rounded),
              title: Text(appLocalizations.generalBookshelf),
            );

          default:
            return ListTile(
              leading: const Icon(Icons.shelves),
              title: Text(appLocalizations.generalBookshelf),
              trailing: const CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
