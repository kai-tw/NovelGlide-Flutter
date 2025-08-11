part of '../backup_service_google_drive.dart';

class BackupServiceGoogleDriveActionButton extends StatelessWidget {
  const BackupServiceGoogleDriveActionButton({
    super.key,
    required this.targetType,
    required this.taskType,
  });

  final BackupTargetType targetType;
  final BackupTaskType taskType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BackupServiceGoogleDriveCubit,
        BackupServiceGoogleDriveState>(
      buildWhen: (BackupServiceGoogleDriveState previous,
              BackupServiceGoogleDriveState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BackupServiceGoogleDriveState state) {
        return IconButton(
          // Show the icon by task type.
          icon: Icon(switch (taskType) {
            BackupTaskType.create => Icons.backup_rounded,
            BackupTaskType.restore => Icons.restore_rounded,
            BackupTaskType.delete => Icons.delete_forever_rounded,
          }),
          // Show tooltip by the task & target type.
          tooltip: switch (taskType) {
            // Create backup case.
            BackupTaskType.create => switch (targetType) {
                BackupTargetType.all => appLocalizations.backupServiceBackupAll,
                BackupTargetType.library =>
                  appLocalizations.backupServiceBackupLibrary,
                BackupTargetType.collection =>
                  appLocalizations.backupServiceBackupCollection,
                BackupTargetType.bookmark =>
                  appLocalizations.backupServiceBackupBookmark,
              },
            // Restore backup case.
            BackupTaskType.restore => switch (targetType) {
                BackupTargetType.all =>
                  appLocalizations.backupServiceRestoreAll,
                BackupTargetType.library =>
                  appLocalizations.backupServiceRestoreLibrary,
                BackupTargetType.collection =>
                  appLocalizations.backupServiceRestoreCollection,
                BackupTargetType.bookmark =>
                  appLocalizations.backupServiceRestoreBookmark,
              },
            // Delete backup case.
            BackupTaskType.delete => switch (targetType) {
                BackupTargetType.all =>
                  appLocalizations.backupServiceDeleteAllBackup,
                BackupTargetType.library =>
                  appLocalizations.backupServiceDeleteLibraryBackup,
                BackupTargetType.collection =>
                  appLocalizations.backupServiceDeleteCollectionBackup,
                BackupTargetType.bookmark =>
                  appLocalizations.backupServiceDeleteBookmarkBackup,
              }
          },
          onPressed: _isEnabled(state) ? () => _onPressed(context) : null,
          // Change the color of icon by task type.
          color: switch (taskType) {
            BackupTaskType.delete => Theme.of(context).colorScheme.error,
            _ => null,
          },
        );
      },
    );
  }

  /// Whether the action button is enabled.
  bool _isEnabled(BackupServiceGoogleDriveState state) {
    final bool isLoaded = state.code.isLoaded;
    final bool libraryExists = state.libraryId != null;
    final bool bookmarkExists = state.bookmarkId != null;
    final bool collectionExists = state.collectionId != null;
    return switch (taskType) {
      BackupTaskType.create => isLoaded,
      BackupTaskType.restore || BackupTaskType.delete => switch (targetType) {
          BackupTargetType.all =>
            isLoaded && (libraryExists || bookmarkExists || collectionExists),
          BackupTargetType.library => isLoaded && libraryExists,
          BackupTargetType.collection => isLoaded && collectionExists,
          BackupTargetType.bookmark => isLoaded && bookmarkExists
        }
    };
  }

  /// Click handler for the action button.
  Future<void> _onPressed(BuildContext context) async {
    final BackupServiceGoogleDriveCubit cubit =
        BlocProvider.of<BackupServiceGoogleDriveCubit>(context);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BackupServiceProcessDialog(
        taskType: taskType,
        targetType: targetType,
      ),
    );

    cubit.refresh();
  }
}
