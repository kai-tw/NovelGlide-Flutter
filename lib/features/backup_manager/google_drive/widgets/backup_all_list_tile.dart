part of '../backup_manager_google_drive.dart';

class _BackupAllListTile extends StatelessWidget {
  const _BackupAllListTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<_Cubit>(context);
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(appLocalizations.backupManagerLabelAll),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<_Cubit, _State>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              final isEnabled = state.code == LoadingStateCode.loaded;
              return IconButton(
                icon: Icon(
                  Icons.backup_outlined,
                  semanticLabel: appLocalizations.backupManagerBackupAll,
                ),
                onPressed: isEnabled
                    ? () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return FutureBuilder<bool>(
                              future: cubit.backupAll(),
                              builder: (context, snapshot) => _buildDialog(
                                context,
                                snapshot,
                                appLocalizations
                                    .backupManagerBackupSuccessfully,
                              ),
                            );
                          },
                        )
                    : null,
              );
            },
          ),
          BlocBuilder<_Cubit, _State>(
            buildWhen: (previous, current) =>
                previous.code != current.code ||
                previous.libraryId != current.libraryId ||
                previous.collectionId != current.collectionId ||
                previous.bookmarkId != current.bookmarkId,
            builder: (context, state) {
              final isEnabled = state.code == LoadingStateCode.loaded &&
                      state.libraryId != null ||
                  state.collectionId != null ||
                  state.bookmarkId != null;
              return IconButton(
                icon: Icon(
                  Icons.restore_outlined,
                  semanticLabel: appLocalizations.backupManagerRestoreAll,
                ),
                onPressed: isEnabled
                    ? () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return FutureBuilder<bool>(
                              future: cubit.restoreAll(),
                              builder: (context, snapshot) => _buildDialog(
                                context,
                                snapshot,
                                appLocalizations
                                    .backupManagerRestoreSuccessfully,
                              ),
                            );
                          },
                        )
                    : null,
              );
            },
          ),
          BlocBuilder<_Cubit, _State>(
            buildWhen: (previous, current) =>
                previous.code != current.code ||
                previous.libraryId != current.libraryId ||
                previous.collectionId != current.collectionId ||
                previous.bookmarkId != current.bookmarkId,
            builder: (context, state) {
              final isEnabled = state.code == LoadingStateCode.loaded &&
                      state.libraryId != null ||
                  state.collectionId != null ||
                  state.bookmarkId != null;
              return IconButton(
                icon: Icon(
                  Icons.delete_outlined,
                  semanticLabel: appLocalizations.backupManagerDeleteAllBackup,
                ),
                onPressed: isEnabled
                    ? () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return FutureBuilder<bool>(
                              future: cubit.deleteAll(),
                              builder: (context, snapshot) => _buildDialog(
                                context,
                                snapshot,
                                appLocalizations
                                    .backupManagerDeleteBackupSuccessfully,
                              ),
                            );
                          },
                        )
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDialog(
    BuildContext context,
    AsyncSnapshot<Object?> snapshot,
    String successLabel,
  ) {
    if (snapshot.hasError) {
      // Handle error state
      // Record the error log
      final logger = Logger();
      logger.e(snapshot.error);
      logger.close();

      // Show the error dialog.
      return CommonErrorDialog(content: snapshot.error.toString());
    } else {
      switch (snapshot.connectionState) {
        case ConnectionState.done:
          // Operation done. Show success dialog.
          return CommonSuccessDialog(title: Text(successLabel));

        default:
          // Show loading dialog while waiting
          return const CommonLoadingDialog();
      }
    }
  }
}