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
        title = appLocalizations.generalAll;
        break;
      case BackupServiceTargetType.library:
        title = appLocalizations.generalBookshelf;
        break;
      case BackupServiceTargetType.collection:
        title = appLocalizations.generalCollections;
        break;
      case BackupServiceTargetType.bookmark:
        title = appLocalizations.generalBookmark(2);
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
