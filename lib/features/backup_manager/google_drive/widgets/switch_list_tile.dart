part of '../backup_manager_google_drive.dart';

class _SwitchListTile extends StatelessWidget {
  const _SwitchListTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupManagerGoogleDriveCubit cubit =
        BlocProvider.of<BackupManagerGoogleDriveCubit>(context);
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (BackupManagerGoogleDriveState previous,
              BackupManagerGoogleDriveState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BackupManagerGoogleDriveState state) {
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
