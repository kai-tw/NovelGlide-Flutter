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
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: BlocBuilder<BackupManagerGoogleDriveCubit,
          BackupManagerGoogleDriveState>(
        buildWhen: (previous, current) =>
            previous.code != current.code || previous.fileId != current.fileId,
        builder: (context, state) {
          return _buildColumn(context, appLocalizations, state);
        },
      ),
    );
  }

  /// Builds the column containing all the UI elements.
  Widget _buildColumn(
    BuildContext context,
    AppLocalizations appLocalizations,
    BackupManagerGoogleDriveState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSwitcher(context, appLocalizations, state),
        _buildLastBackupTile(appLocalizations, state),
        _buildActionTiles(context, appLocalizations, state),
      ],
    );
  }

  Widget _buildSwitcher(
    BuildContext context,
    AppLocalizations appLocalizations,
    BackupManagerGoogleDriveState state,
  ) {
    return SwitchListTile(
      title: Text(appLocalizations.backupManagerGoogleDriveBackup),
      secondary: const Icon(Icons.cloud_rounded),
      value: state.code == BackupManagerGoogleDriveCode.idle,
      onChanged: (value) =>
          BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
              .setEnabled(value),
    );
  }

  /// Builds the list tile showing the last backup time.
  Widget _buildLastBackupTile(
    AppLocalizations appLocalizations,
    BackupManagerGoogleDriveState state,
  ) {
    return ListTile(
      leading: const Icon(Icons.calendar_today_rounded),
      title: Text(appLocalizations.backupManagerLastTime),
      subtitle: Text(
        DateTimeUtility.format(state.metadata?.modifiedTime, defaultValue: '-'),
      ),
    );
  }

  /// Builds the action tiles for creating, restoring, and deleting backups.
  Widget _buildActionTiles(
    BuildContext context,
    AppLocalizations appLocalizations,
    BackupManagerGoogleDriveState state,
  ) {
    return Column(
      children: [
        BackupManagerActionListTile(
          iconData: Icons.backup_outlined,
          titleLabel: appLocalizations.backupManagerCreate,
          successLabel: appLocalizations.backupManagerCreateSuccessfully,
          enabled: state.code == BackupManagerGoogleDriveCode.idle,
          future: () => BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
              .createBackup(),
          onComplete: () =>
              BlocProvider.of<BackupManagerGoogleDriveCubit>(context).refresh(),
        ),
        BackupManagerActionListTile(
          iconData: Icons.restore_rounded,
          titleLabel: appLocalizations.backupManagerRestoreBackup,
          successLabel: appLocalizations.backupManagerRestoreSuccessfully,
          enabled: state.code == BackupManagerGoogleDriveCode.idle &&
              state.fileId != null,
          future: () => BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
              .restoreBackup(),
        ),
        BackupManagerActionListTile(
          iconData: Icons.delete_outlined,
          titleLabel: appLocalizations.backupManagerDeleteBackup,
          successLabel: appLocalizations.backupManagerDeleteBackupSuccessfully,
          enabled: state.code == BackupManagerGoogleDriveCode.idle &&
              state.fileId != null,
          future: () => BlocProvider.of<BackupManagerGoogleDriveCubit>(context)
              .deleteBackup(),
          onComplete: () =>
              BlocProvider.of<BackupManagerGoogleDriveCubit>(context).refresh(),
        ),
      ],
    );
  }
}
