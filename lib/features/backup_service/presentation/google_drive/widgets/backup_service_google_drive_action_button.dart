part of '../backup_service_google_drive.dart';

class BackupServiceGoogleDriveActionButton extends StatelessWidget {
  const BackupServiceGoogleDriveActionButton({
    super.key,
    required this.targetType,
    required this.taskType,
  });

  final BackupTargetType targetType;
  final BackupTaskType taskType;

  /// The icon data for the action button.
  IconData get _iconData {
    switch (taskType) {
      case BackupTaskType.create:
        return Icons.backup_rounded;

      case BackupTaskType.restore:
        return Icons.restore_rounded;

      case BackupTaskType.delete:
        return Icons.delete_forever_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackupServiceGoogleDriveCubit,
        BackupServiceGoogleDriveState>(
      buildWhen: (BackupServiceGoogleDriveState previous,
              BackupServiceGoogleDriveState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BackupServiceGoogleDriveState state) {
        return IconButton(
          icon: Icon(_iconData),
          tooltip: _getLabel(
            context,
            taskType: taskType,
            targetType: targetType,
          ),
          onPressed: _isEnabled(state) ? () => _onPressed(context) : null,
          color: _getColor(context),
        );
      },
    );
  }

  /// The tooltip for the action button.
  String _getLabel(
    BuildContext context, {
    required BackupTaskType taskType,
    required BackupTargetType targetType,
  }) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    switch (taskType) {
      case BackupTaskType.create:
        switch (targetType) {
          case BackupTargetType.all:
            return appLocalizations.backupServiceBackupAll;
          case BackupTargetType.library:
            return appLocalizations.backupServiceBackupLibrary;
          case BackupTargetType.collection:
            return appLocalizations.backupServiceBackupCollection;
          case BackupTargetType.bookmark:
            return appLocalizations.backupServiceBackupBookmark;
        }

      case BackupTaskType.restore:
        switch (targetType) {
          case BackupTargetType.all:
            return appLocalizations.backupServiceRestoreAll;
          case BackupTargetType.library:
            return appLocalizations.backupServiceRestoreLibrary;
          case BackupTargetType.collection:
            return appLocalizations.backupServiceRestoreCollection;
          case BackupTargetType.bookmark:
            return appLocalizations.backupServiceRestoreBookmark;
        }

      case BackupTaskType.delete:
        switch (targetType) {
          case BackupTargetType.all:
            return appLocalizations.backupServiceDeleteAllBackup;
          case BackupTargetType.library:
            return appLocalizations.backupServiceDeleteLibraryBackup;
          case BackupTargetType.collection:
            return appLocalizations.backupServiceDeleteCollectionBackup;
          case BackupTargetType.bookmark:
            return appLocalizations.backupServiceDeleteBookmarkBackup;
        }
    }
  }

  /// Whether the action button is enabled.
  bool _isEnabled(BackupServiceGoogleDriveState state) {
    switch (taskType) {
      case BackupTaskType.create:
        return state.code.isLoaded;
      case BackupTaskType.restore:
      case BackupTaskType.delete:
        switch (targetType) {
          case BackupTargetType.all:
            return state.code.isLoaded &&
                (state.libraryId != null ||
                    state.collectionId != null ||
                    state.bookmarkId != null);
          case BackupTargetType.library:
            return state.code.isLoaded && state.libraryId != null;
          case BackupTargetType.collection:
            return state.code.isLoaded && state.collectionId != null;
          case BackupTargetType.bookmark:
            return state.code.isLoaded && state.bookmarkId != null;
        }
    }
  }

  /// The color for the action button.
  Color? _getColor(BuildContext context) {
    switch (taskType) {
      case BackupTaskType.create:
      case BackupTaskType.restore:
        return null;
      case BackupTaskType.delete:
        return Theme.of(context).colorScheme.error;
    }
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
        libraryId: cubit.state.libraryId,
        collectionId: cubit.state.collectionId,
        bookmarkId: cubit.state.bookmarkId,
      ),
    );

    cubit.refresh();
  }
}
