part of '../backup_service_google_drive.dart';

class BackupServiceGoogleDriveSwitchListTile extends StatelessWidget {
  const BackupServiceGoogleDriveSwitchListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupServiceGoogleDriveCubit cubit =
        BlocProvider.of<BackupServiceGoogleDriveCubit>(context);

    // Build the switch list tile.
    return BlocBuilder<BackupServiceGoogleDriveCubit,
        BackupServiceGoogleDriveState>(
      buildWhen: (BackupServiceGoogleDriveState previous,
              BackupServiceGoogleDriveState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BackupServiceGoogleDriveState state) {
        return SwitchListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
          title: Text(appLocalizations.backupServiceGoogleDrive),
          secondary: const Icon(Icons.cloud_rounded),
          value: state.code == LoadingStateCode.loaded,
          onChanged: state.code != LoadingStateCode.loading
              ? (bool value) async {
                  try {
                    await cubit.setEnabled(value);
                    cubit.refresh();
                  } on GoogleAuthSignInException {
                    if (context.mounted) {
                      ExceptionService.showExceptionDialog(
                        context: context,
                        contents: appLocalizations.exceptionGoogleDriveSignIn,
                      );
                    }
                  } on GoogleDrivePermissionException {
                    if (context.mounted) {
                      ExceptionService.showExceptionDialog(
                        context: context,
                        contents: appLocalizations
                            .exceptionGoogleDrivePermissionDenied,
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ExceptionService.showExceptionDialog(
                        context: context,
                        contents: appLocalizations.exceptionUnknownError,
                      );
                    }
                  }
                }
              : null,
        );
      },
    );
  }
}
