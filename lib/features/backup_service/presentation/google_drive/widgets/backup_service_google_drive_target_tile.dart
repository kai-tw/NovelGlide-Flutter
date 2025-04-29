part of '../backup_service_google_drive.dart';

class BackupServiceGoogleDriveTargetTile extends StatelessWidget {
  const BackupServiceGoogleDriveTargetTile({
    super.key,
    required this.targetType,
  });

  final BackupServiceTargetType targetType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    String title;

    switch (targetType) {
      case BackupServiceTargetType.all:
        title = appLocalizations.backupServiceLabelAll;
        break;
      case BackupServiceTargetType.library:
        title = appLocalizations.backupServiceLabelLibrary;
        break;
      case BackupServiceTargetType.collection:
        title = appLocalizations.backupServiceLabelCollection;
        break;
      case BackupServiceTargetType.bookmark:
        title = appLocalizations.backupServiceLabelBookmark;
        break;
    }

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: BackupServiceTaskType.values
            .map<Widget>(
              (BackupServiceTaskType taskType) =>
                  BackupServiceGoogleDriveActionButton(
                targetType: targetType,
                taskType: taskType,
              ),
            )
            .toList(),
      ),
    );
  }
}
