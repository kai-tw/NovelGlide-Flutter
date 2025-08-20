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

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(switch (targetType) {
        BackupTargetType.all => appLocalizations.generalAll,
        BackupTargetType.library => appLocalizations.generalBookshelf,
        BackupTargetType.collection => appLocalizations.generalCollection(2),
        BackupTargetType.bookmark => appLocalizations.generalBookmark(2),
      }),
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
