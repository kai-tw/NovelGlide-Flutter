part of '../../backup_manager_google_drive.dart';

class _ProcessAllBookmarkTile extends StatelessWidget {
  const _ProcessAllBookmarkTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_ProcessCubit, _ProcessState>(
      buildWhen: (previous, current) =>
          previous.isBookmarkRunning != current.isBookmarkRunning ||
          previous.bookmarkStep != current.bookmarkStep ||
          previous.bookmarkProgress != current.bookmarkProgress,
      builder: (context, state) {
        // Disable state.
        if (!state.isBookmarkRunning) {
          return ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: Text(appLocalizations.backupManagerLabelBookmark),
            enabled: false,
          );
        }

        switch (state.bookmarkStep) {
          case _ProcessStep.upload:
            return ListTile(
              leading: const Icon(Icons.upload_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.download:
            return ListTile(
              leading: const Icon(Icons.download_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.delete:
            return ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
              trailing: const CircularProgressIndicator(),
            );

          case _ProcessStep.done:
            return ListTile(
              iconColor: Colors.green,
              textColor: Colors.green,
              leading: const Icon(Icons.check_outlined),
              title: Text(appLocalizations.backupManagerLabelBookmark),
            );

          case _ProcessStep.error:
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
