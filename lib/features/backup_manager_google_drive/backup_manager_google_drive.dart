import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/datetime_utility.dart';
import '../backup_manager/widgets/backup_manager_action_list_tile.dart';
import 'bloc/backup_manager_google_drive_bloc.dart';

class BackupManagerGoogleDrive extends StatelessWidget {
  const BackupManagerGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BackupManagerGoogleDriveCubit()..init(),
      child: _buildContent(context),
    );
  }

  /// Builds the main content of the Backup Manager.
  Widget _buildContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSwitcher(context),
          _buildLastBackupTile(context),
          _buildCreateActionTile(context),
          _buildRestoreActionTile(context),
          _buildDeleteActionTile(context),
        ],
      ),
    );
  }

  Widget _buildSwitcher(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (prev, curr) => prev.code != curr.code,
      builder: (context, state) {
        return SwitchListTile(
          title: Text(
            appLocalizations?.backupManagerGoogleDriveBackup ??
                'Google Drive Backup',
          ),
          secondary: const Icon(Icons.cloud_rounded),
          value: state.code == BackupManagerGoogleDriveCode.idle,
          onChanged: (value) =>
              BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
                  .setEnabled(value),
        );
      },
    );
  }

  /// Builds the list tile showing the last backup time.
  Widget _buildLastBackupTile(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.calendar_today_rounded),
      title: Text(
        appLocalizations?.backupManagerLastTime ?? 'Last backup time',
      ),
      subtitle: BlocBuilder<BackupManagerGoogleDriveCubit,
          BackupManagerGoogleDriveState>(
        buildWhen: (prev, curr) =>
            prev.metadata?.modifiedTime != curr.metadata?.modifiedTime,
        builder: (context, state) {
          return Text(
            DateTimeUtility.format(state.metadata?.modifiedTime,
                defaultValue: '-'),
          );
        },
      ),
    );
  }

  Widget _buildCreateActionTile(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (prev, curr) => prev.code != curr.code,
      builder: (context, state) {
        return BackupManagerActionListTile(
          iconData: Icons.backup_outlined,
          titleLabel: appLocalizations?.backupManagerCreate ?? 'Backup now',
          successLabel: appLocalizations?.backupManagerCreateSuccessfully ??
              'Backup successfully.',
          enabled: state.code == BackupManagerGoogleDriveCode.idle,
          future: () => BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
              .createBackup(),
          onComplete: () =>
              BlocProvider.of<BackupManagerGoogleDriveCubit>(context).refresh(),
        );
      },
    );
  }

  Widget _buildRestoreActionTile(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (prev, curr) => prev.code != curr.code,
      builder: (context, state) {
        return BackupManagerActionListTile(
          iconData: Icons.restore_rounded,
          titleLabel: appLocalizations?.backupManagerRestoreBackup ??
              'Restore from backup',
          successLabel: appLocalizations?.backupManagerRestoreSuccessfully ??
              'Successfully restore from the backup.',
          enabled: state.code == BackupManagerGoogleDriveCode.idle &&
              state.fileId != null,
          future: () => BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
              .restoreBackup(),
        );
      },
    );
  }

  Widget _buildDeleteActionTile(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (prev, curr) => prev.code != curr.code,
      builder: (context, state) {
        return BackupManagerActionListTile(
          iconData: Icons.delete_outlined,
          titleLabel:
              appLocalizations?.backupManagerDeleteBackup ?? 'Delete backup',
          successLabel:
              appLocalizations?.backupManagerDeleteBackupSuccessfully ??
                  'Successfully delete backup.',
          enabled: state.code == BackupManagerGoogleDriveCode.idle &&
              state.fileId != null,
          future: () => BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
              .deleteBackup(),
          onComplete: () =>
              BlocProvider.of<BackupManagerGoogleDriveCubit>(context).refresh(),
        );
      },
    );
  }
}
