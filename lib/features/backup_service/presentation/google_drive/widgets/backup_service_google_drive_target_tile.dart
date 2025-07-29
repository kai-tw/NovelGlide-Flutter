part of '../backup_service_google_drive.dart';

class BackupServiceGoogleDriveTargetTile extends StatelessWidget {
  const BackupServiceGoogleDriveTargetTile({
    super.key,
    required this.targetType,
  });

  final BackupTargetType targetType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    String title;

    switch (targetType) {
      case BackupTargetType.all:
        title = appLocalizations.generalAll;
        break;
      case BackupTargetType.library:
        title = appLocalizations.generalBookshelf;
        break;
      case BackupTargetType.collection:
        title = appLocalizations.generalCollection(2);
        break;
      case BackupTargetType.bookmark:
        title = appLocalizations.generalBookmark(2);
        break;
    }

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: BackupTaskType.values
            .map<Widget>(
              (BackupTaskType taskType) => BackupServiceGoogleDriveActionButton(
                targetType: targetType,
                taskType: taskType,
              ),
            )
            .toList(),
      ),
    );
  }
}
