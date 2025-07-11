part of '../backup_service_process_dialog.dart';

class _BookmarkTile extends StatelessWidget {
  const _BookmarkTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BackupServiceProcessCubit, BackupServiceProcessState>(
      buildWhen: (BackupServiceProcessState previous, BackupServiceProcessState current) =>
          previous.bookmark != current.bookmark,
      builder: (BuildContext context, BackupServiceProcessState state) {
        switch (state.bookmark.step) {
          case BackupServiceProcessStepCode.disabled:
            return ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: Text(appLocalizations.generalBookmarks),
              enabled: false,
            );

          case BackupServiceProcessStepCode.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.generalBookmarks),
              trailing: const CircularProgressIndicator(),
            );

          case BackupServiceProcessStepCode.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.generalBookmarks),
              trailing: CircularProgressIndicator(
                value: state.bookmark.progress,
              ),
            );

          case BackupServiceProcessStepCode.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.generalBookmarks),
              trailing: const CircularProgressIndicator(),
            );

          case BackupServiceProcessStepCode.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.generalBookmarks),
            );

          case BackupServiceProcessStepCode.error:
            return ListTile(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              leading: const Icon(Icons.error_outline_rounded),
              title: Text(appLocalizations.generalBookmarks),
            );

          default:
            return ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: Text(appLocalizations.generalBookmarks),
              trailing: const CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
