part of '../backup_service_google_drive.dart';

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.targetType,
    required this.taskType,
  });

  final BackupServiceTargetType targetType;
  final BackupServiceTaskType taskType;

  /// The icon data for the action button.
  IconData get _iconData {
    switch (taskType) {
      case BackupServiceTaskType.backup:
        return Icons.backup_rounded;

      case BackupServiceTaskType.restore:
        return Icons.restore_rounded;

      case BackupServiceTaskType.delete:
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
    required BackupServiceTaskType taskType,
    required BackupServiceTargetType targetType,
  }) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    switch (taskType) {
      case BackupServiceTaskType.backup:
        switch (targetType) {
          case BackupServiceTargetType.all:
            return appLocalizations.backupManagerBackupAll;
          case BackupServiceTargetType.library:
            return appLocalizations.backupManagerBackupLibrary;
          case BackupServiceTargetType.collection:
            return appLocalizations.backupManagerBackupCollection;
          case BackupServiceTargetType.bookmark:
            return appLocalizations.backupManagerBackupBookmark;
        }

      case BackupServiceTaskType.restore:
        switch (targetType) {
          case BackupServiceTargetType.all:
            return appLocalizations.backupManagerRestoreAll;
          case BackupServiceTargetType.library:
            return appLocalizations.backupManagerRestoreLibrary;
          case BackupServiceTargetType.collection:
            return appLocalizations.backupManagerRestoreCollection;
          case BackupServiceTargetType.bookmark:
            return appLocalizations.backupManagerRestoreBookmark;
        }

      case BackupServiceTaskType.delete:
        switch (targetType) {
          case BackupServiceTargetType.all:
            return appLocalizations.backupManagerDeleteAllBackup;
          case BackupServiceTargetType.library:
            return appLocalizations.backupManagerDeleteLibraryBackup;
          case BackupServiceTargetType.collection:
            return appLocalizations.backupManagerDeleteCollectionBackup;
          case BackupServiceTargetType.bookmark:
            return appLocalizations.backupManagerDeleteBookmarkBackup;
        }
    }
  }

  /// Whether the action button is enabled.
  bool _isEnabled(BackupServiceGoogleDriveState state) {
    switch (taskType) {
      case BackupServiceTaskType.backup:
        return state.code.isLoaded;
      case BackupServiceTaskType.restore:
      case BackupServiceTaskType.delete:
        switch (targetType) {
          case BackupServiceTargetType.all:
            return state.code.isLoaded &&
                state.libraryId != null &&
                state.collectionId != null &&
                state.bookmarkId != null;
          case BackupServiceTargetType.library:
            return state.code.isLoaded && state.libraryId != null;
          case BackupServiceTargetType.collection:
            return state.code.isLoaded && state.collectionId != null;
          case BackupServiceTargetType.bookmark:
            return state.code.isLoaded && state.bookmarkId != null;
        }
    }
  }

  /// The color for the action button.
  Color? _getColor(BuildContext context) {
    switch (taskType) {
      case BackupServiceTaskType.backup:
      case BackupServiceTaskType.restore:
        return null;
      case BackupServiceTaskType.delete:
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
