import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

import '../../../enum/loading_state_code.dart';
import '../../backup_manager/dialog/backup_manager_error_dialog.dart';
import '../../backup_manager/dialog/backup_manager_loading_dialog.dart';
import '../../backup_manager/dialog/backup_manager_success_dialog.dart';
import '../bloc/backup_manager_google_drive_bloc.dart';

class BackupManagerGoogleDriveBooks extends StatelessWidget {
  const BackupManagerGoogleDriveBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BackupManagerGoogleDriveCubit>(context);
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(appLocalizations.backupManagerLabelLibrary),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<BackupManagerGoogleDriveCubit,
              BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              final isEnabled = state.code == LoadingStateCode.loaded;
              return IconButton(
                icon: Icon(
                  Icons.backup_outlined,
                  semanticLabel: appLocalizations.backupManagerBackupLibrary,
                ),
                onPressed: isEnabled
                    ? () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return FutureBuilder<bool>(
                              future: cubit.backupLibrary(),
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
          BlocBuilder<BackupManagerGoogleDriveCubit,
              BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) =>
                previous.code != current.code ||
                previous.libraryId != current.libraryId,
            builder: (context, state) {
              final isEnabled = state.code == LoadingStateCode.loaded &&
                  state.libraryId != null;
              return IconButton(
                icon: Icon(
                  Icons.restore_outlined,
                  semanticLabel: appLocalizations.backupManagerRestoreLibrary,
                ),
                onPressed: isEnabled
                    ? () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return FutureBuilder<bool>(
                              future: cubit.restoreLibrary(),
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
          BlocBuilder<BackupManagerGoogleDriveCubit,
              BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) =>
                previous.code != current.code ||
                previous.libraryId != current.libraryId,
            builder: (context, state) {
              final isEnabled = state.code == LoadingStateCode.loaded &&
                  state.libraryId != null;
              return IconButton(
                icon: Icon(
                  Icons.delete_outlined,
                  semanticLabel:
                      appLocalizations.backupManagerDeleteLibraryBackup,
                ),
                onPressed: isEnabled
                    ? () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return FutureBuilder<bool>(
                              future: cubit.deleteLibrary(),
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
      return BackupManagerErrorDialog(content: snapshot.error.toString());
    } else {
      switch (snapshot.connectionState) {
        case ConnectionState.done:
          // Operation done. Show success dialog.
          return BackupManagerSuccessDialog(content: successLabel);

        default:
          // Show loading dialog while waiting
          return const BackupManagerLoadingDialog();
      }
    }
  }
}
