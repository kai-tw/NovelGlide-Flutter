part of '../backup_service_process_dialog.dart';

class _BookmarkTile extends StatelessWidget {
  const _BookmarkTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BackupServiceProcessBookmarkCubit,
        BackupServiceProcessItemState>(
      builder: (BuildContext context, BackupServiceProcessItemState state) {
        switch (state.step) {
          case BackupProgressStepCode.disabled:
            return ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: Text(appLocalizations.generalBookmark(2)),
              enabled: false,
            );

          case BackupProgressStepCode.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.generalBookmark(2)),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupProgressStepCode.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.generalBookmark(2)),
              trailing: CircularProgressIndicator(
                value: state.progress,
              ),
            );

          case BackupProgressStepCode.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.generalBookmark(2)),
              trailing: const CircularProgressIndicator(),
            );

          case BackupProgressStepCode.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.generalBookmark(2)),
            );

          case BackupProgressStepCode.error:
            return ListTile(
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              leading: const Icon(Icons.error_outline_rounded),
              title: Text(appLocalizations.generalBookmark(2)),
            );

          default:
            return ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: Text(appLocalizations.generalBookmark(2)),
              trailing: const CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
