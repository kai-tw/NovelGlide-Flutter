part of '../backup_service_google_drive.dart';

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.targetType,
    required this.taskType,
  });

  final BackupServiceTargetType targetType;
  final BackupServiceTaskType taskType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupServiceGoogleDriveCubit cubit =
        BlocProvider.of<BackupServiceGoogleDriveCubit>(context);
    IconData iconData;
    String label;

    switch (taskType) {
      case BackupServiceTaskType.backup:
        switch (targetType) {
          case BackupServiceTargetType.all:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupAll;
            break;
          case BackupServiceTargetType.library:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupLibrary;
            break;
          case BackupServiceTargetType.collection:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupCollection;
            break;
          case BackupServiceTargetType.bookmark:
            iconData = Icons.backup_outlined;
            label = appLocalizations.backupManagerBackupBookmark;
            break;
        }
        break;
      case BackupServiceTaskType.restore:
        switch (targetType) {
          case BackupServiceTargetType.all:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreAll;
            break;
          case BackupServiceTargetType.library:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreLibrary;
            break;
          case BackupServiceTargetType.collection:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreCollection;
            break;
          case BackupServiceTargetType.bookmark:
            iconData = Icons.restore_outlined;
            label = appLocalizations.backupManagerRestoreBookmark;
            break;
        }
        break;
      case BackupServiceTaskType.delete:
        switch (targetType) {
          case BackupServiceTargetType.all:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteAllBackup;
            break;
          case BackupServiceTargetType.library:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteLibraryBackup;
            break;
          case BackupServiceTargetType.collection:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteCollectionBackup;
            break;
          case BackupServiceTargetType.bookmark:
            iconData = Icons.delete_outlined;
            label = appLocalizations.backupManagerDeleteBookmarkBackup;
            break;
        }
        break;
    }

    return BlocBuilder<BackupServiceGoogleDriveCubit,
        BackupServiceGoogleDriveState>(
      buildWhen: (BackupServiceGoogleDriveState previous,
              BackupServiceGoogleDriveState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BackupServiceGoogleDriveState state) {
        final bool isEnabled = state.code.isLoaded;
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
                    builder: (_) => BackupServiceProcessDialog(
                      taskType: taskType,
                      targetType: targetType,
                      libraryId: cubit.state.libraryId!,
                      collectionId: cubit.state.collectionId!,
                      bookmarkId: cubit.state.bookmarkId!,
                    ),
                  ).then((_) => cubit.refresh());
                }
              : null,
        );
      },
    );
  }
}
