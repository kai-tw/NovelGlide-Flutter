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
    final cubit = BlocProvider.of<BackupManagerGoogleDriveCubit>(context);

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
          return _buildColumn(context, appLocalizations, cubit, state);
        },
      ),
    );
  }

  /// Builds the column containing all the UI elements.
  Widget _buildColumn(
    BuildContext context,
    AppLocalizations appLocalizations,
    BackupManagerGoogleDriveCubit cubit,
    BackupManagerGoogleDriveState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLastBackupTile(appLocalizations, state),
        _buildActionTiles(appLocalizations, cubit, state),
      ],
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
    AppLocalizations appLocalizations,
    BackupManagerGoogleDriveCubit cubit,
    BackupManagerGoogleDriveState state,
  ) {
    return Column(
      children: [
        BackupManagerActionListTile(
          iconData: Icons.backup_outlined,
          titleLabel: appLocalizations.backupManagerCreate,
          successLabel: appLocalizations.backupManagerCreateSuccessfully,
          enabled: state.code == BackupManagerGoogleDriveCode.idle,
          future: cubit.createBackup,
          onComplete: cubit.refresh,
        ),
        BackupManagerActionListTile(
          iconData: Icons.restore_rounded,
          titleLabel: appLocalizations.backupManagerRestoreBackup,
          successLabel: appLocalizations.backupManagerRestoreSuccessfully,
          enabled: state.code == BackupManagerGoogleDriveCode.idle &&
              state.fileId != null,
          future: cubit.restoreBackup,
        ),
        BackupManagerActionListTile(
          iconData: Icons.delete_outlined,
          titleLabel: appLocalizations.backupManagerDeleteBackup,
          successLabel: appLocalizations.backupManagerDeleteBackupSuccessfully,
          enabled: state.code == BackupManagerGoogleDriveCode.idle &&
              state.fileId != null,
          future: cubit.deleteBackup,
          onComplete: cubit.refresh,
        ),
      ],
    );
  }
}
