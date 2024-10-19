import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/datetime_utility.dart';
import '../backup_manager/widgets/backup_manager_action_list_tile.dart';
import 'bloc/backup_manager_google_drive_bloc.dart';

class BackupManagerGoogleDrive extends StatelessWidget {
  const BackupManagerGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => BackupManagerGoogleDriveCubit(),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(24.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: BlocBuilder<BackupManagerGoogleDriveCubit,
            BackupManagerGoogleDriveState>(
          buildWhen: (prev, curr) =>
              prev.isReady != curr.isReady ||
              prev.lastBackupTime != curr.lastBackupTime ||
              prev.libraryId != curr.libraryId,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Switch to enable/disable Google Drive backup
                SwitchListTile(
                  title: Text(appLocalizations.backupManagerGoogleDrive),
                  secondary: const Icon(Icons.cloud_rounded),
                  value: state.isReady,
                  onChanged: (value) =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .setEnabled(value),
                ),
                // Show the last backup time
                ListTile(
                  leading: const Icon(Icons.calendar_today_rounded),
                  title: Text(appLocalizations.backupManagerLastTime),
                  subtitle: Text(
                    DateTimeUtility.format(
                      state.lastBackupTime,
                      defaultValue: '-',
                    ),
                  ),
                ),

                const Divider(),

                // Backup Functionality
                // Backup all to Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.backup_outlined,
                  titleLabel: appLocalizations.backupManagerBackupAll,
                  successLabel:
                      appLocalizations.backupManagerBackupSuccessfully,
                  enabled: state.isReady,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .backupAll(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),
                // Backup library to Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.backup_outlined,
                  titleLabel: appLocalizations.backupManagerBackupLibrary,
                  successLabel:
                      appLocalizations.backupManagerBackupSuccessfully,
                  enabled: state.isReady,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .backupLibrary(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),
                // Backup collections to Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.backup_outlined,
                  titleLabel: appLocalizations.backupManagerBackupCollection,
                  successLabel:
                      appLocalizations.backupManagerBackupSuccessfully,
                  enabled: state.isReady,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .backupCollections(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),
                // Backup bookmarks to Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.bookmark_add_outlined,
                  titleLabel: appLocalizations.backupManagerBackupBookmark,
                  successLabel:
                      appLocalizations.backupManagerBackupSuccessfully,
                  enabled: state.isReady,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .backupBookmarks(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),

                const Divider(),

                // Restore Functionality
                // Restore all books from Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.restore_rounded,
                  titleLabel: appLocalizations.backupManagerRestoreAll,
                  successLabel:
                      appLocalizations.backupManagerRestoreSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .restoreAll(),
                ),
                // Restore library from Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.library_books_outlined,
                  titleLabel: appLocalizations.backupManagerRestoreLibrary,
                  successLabel:
                      appLocalizations.backupManagerRestoreSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .restoreLibrary(),
                ),
                // Restore collections from Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.collections_bookmark_outlined,
                  titleLabel: appLocalizations.backupManagerRestoreCollection,
                  successLabel:
                      appLocalizations.backupManagerRestoreSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .restoreCollections(),
                ),
                // Restore bookmarks from Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.bookmark_border,
                  titleLabel: appLocalizations.backupManagerRestoreBookmark,
                  successLabel:
                      appLocalizations.backupManagerRestoreSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .restoreBookmarks(),
                ),

                const Divider(),

                // Delete backups Functionality
                // Delete all backups in Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.delete_outlined,
                  titleLabel: appLocalizations.backupManagerDeleteAllBackup,
                  successLabel:
                      appLocalizations.backupManagerDeleteBackupSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .deleteAll(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),
                // Delete library backup from Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.library_books_outlined,
                  titleLabel: appLocalizations.backupManagerDeleteLibraryBackup,
                  successLabel:
                      appLocalizations.backupManagerDeleteBackupSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .deleteLibrary(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),
                // Delete collections backup from Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.collections_bookmark_outlined,
                  titleLabel:
                      appLocalizations.backupManagerDeleteCollectionBackup,
                  successLabel:
                      appLocalizations.backupManagerDeleteBackupSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .deleteCollections(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),
                // Delete bookmarks backup from Google Drive
                BackupManagerActionListTile(
                  iconData: Icons.bookmark_border,
                  titleLabel:
                      appLocalizations.backupManagerDeleteBookmarkBackup,
                  successLabel:
                      appLocalizations.backupManagerDeleteBackupSuccessfully,
                  enabled: state.isReady && state.libraryId != null,
                  future: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .deleteBookmarks(),
                  onComplete: () =>
                      BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                          .refresh(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
