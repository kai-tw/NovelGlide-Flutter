part of '../backup_manager_google_drive.dart';

class _SwitchListTile extends StatelessWidget {
  const _SwitchListTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BackupManagerGoogleDriveCubit>(context);
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
          title: Text(appLocalizations.backupManagerGoogleDrive),
          secondary: const Icon(Icons.cloud_rounded),
          value: state.code == LoadingStateCode.loaded,
          onChanged: (value) async {
            try {
              await cubit.setEnabled(value);
              cubit.refresh();
            } catch (e) {
              if (context.mounted) {
                _errorHandler(context, e);
              }
            }
          },
        );
      },
    );
  }

  void _errorHandler(BuildContext context, Object e) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        if (e is GoogleDriveSignInException) {
          return CommonErrorDialog(
            content: appLocalizations.exceptionGoogleDriveSignIn,
          );
        }
        if (e is GoogleDrivePermissionDeniedException) {
          return CommonErrorDialog(
            content: appLocalizations.exceptionGoogleDrivePermissionDenied,
          );
        }
        return CommonErrorDialog(
          content: appLocalizations.exceptionUnknownError,
        );
      },
    );
  }
}
