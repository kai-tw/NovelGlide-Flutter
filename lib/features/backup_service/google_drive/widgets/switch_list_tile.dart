part of '../backup_service_google_drive.dart';

class _SwitchListTile extends StatelessWidget {
  const _SwitchListTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupServiceGoogleDriveCubit cubit =
        BlocProvider.of<BackupServiceGoogleDriveCubit>(context);
    return BlocBuilder<BackupServiceGoogleDriveCubit,
        BackupServiceGoogleDriveState>(
      buildWhen: (BackupServiceGoogleDriveState previous,
              BackupServiceGoogleDriveState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BackupServiceGoogleDriveState state) {
        return SwitchListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
          title: Text(appLocalizations.backupManagerGoogleDrive),
          secondary: const Icon(Icons.cloud_rounded),
          value: state.code == LoadingStateCode.loaded,
          onChanged: state.code != LoadingStateCode.loading
              ? (bool value) async {
                  try {
                    await cubit.setEnabled(value);
                    cubit.refresh();
                  } on PlatformException catch (e) {
                    if (context.mounted) {
                      _errorHandler(context, e);
                    }
                  }
                }
              : null,
        );
      },
    );
  }

  void _errorHandler(BuildContext context, PlatformException e) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        switch (e.code) {
          case GoogleSignIn.kSignInFailedError:
            return CommonErrorDialog(
              content: appLocalizations.exceptionGoogleDriveSignIn,
            );

          case ExceptionCode.googleDrivePermissionDenied:
            return CommonErrorDialog(
              content: appLocalizations.exceptionGoogleDrivePermissionDenied,
            );

          default:
            return CommonErrorDialog(
              content: appLocalizations.exceptionUnknownError,
            );
        }
      },
    );
  }
}
