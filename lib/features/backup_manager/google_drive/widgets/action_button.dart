part of '../backup_manager_google_drive.dart';

class _ActionButton extends StatelessWidget {
  final BackupManagerTargetType targetType;
  final BackupManagerTaskType taskType;

  const _ActionButton({
    required this.targetType,
    required this.taskType,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BackupManagerGoogleDriveCubit>(context);
    IconData iconData;
    String label;

    switch (taskType) {
      case BackupManagerTaskType.backup:
        switch (targetType) {
          case BackupManagerTargetType.all:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupAll;
            break;
          case BackupManagerTargetType.library:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupLibrary;
            break;
          case BackupManagerTargetType.collection:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupCollection;
            break;
          case BackupManagerTargetType.bookmark:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupBookmark;
            break;
        }
        break;
      case BackupManagerTaskType.restore:
        switch (targetType) {
          case BackupManagerTargetType.all:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreAll;
            break;
          case BackupManagerTargetType.library:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreLibrary;
            break;
          case BackupManagerTargetType.collection:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreCollection;
            break;
          case BackupManagerTargetType.bookmark:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreBookmark;
            break;
        }
        break;
      case BackupManagerTaskType.delete:
        switch (targetType) {
          case BackupManagerTargetType.all:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteAllBackup;
            break;
          case BackupManagerTargetType.library:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteLibraryBackup;
            break;
          case BackupManagerTargetType.collection:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteCollectionBackup;
            break;
          case BackupManagerTargetType.bookmark:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteBookmarkBackup;
            break;
        }
        break;
    }

    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded;
        return IconButton(
          icon: Icon(
            iconData,
            semanticLabel: label,
          ),
          onPressed: isEnabled
              ? () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => BackupManagerProcessAllDialog(
                      taskType: taskType,
                      targetType: targetType,
                      libraryId: cubit.state.libraryId!,
                      collectionId: cubit.state.collectionId!,
                      bookmarkId: cubit.state.bookmarkId!,
                    ),
                  ).then((value) => cubit.refresh());
                }
              : null,
        );
      },
    );
  }
}
