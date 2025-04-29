part of '../backup_service_google_drive.dart';

class BackupServiceGoogleDriveTimeTile extends StatelessWidget {
  const BackupServiceGoogleDriveTimeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BackupServiceGoogleDriveCubit,
        BackupServiceGoogleDriveState>(
      buildWhen: (BackupServiceGoogleDriveState previous,
              BackupServiceGoogleDriveState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BackupServiceGoogleDriveState state) {
        final bool isLoading = state.code == LoadingStateCode.loading;
        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
          leading: const Icon(Icons.calendar_month_rounded),
          title: Text(appLocalizations.backupManagerLastTime),
          subtitle: Text(
            DateTimeUtils.format(
              state.lastBackupTime,
              defaultValue: '-',
            ),
          ),
          trailing: isLoading ? const CircularProgressIndicator() : null,
        );
      },
    );
  }
}
