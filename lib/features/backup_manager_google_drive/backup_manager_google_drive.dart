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
      child: _BackupManagerGoogleDrive(key: key),
    );
  }
}

class _BackupManagerGoogleDrive extends StatelessWidget {
  const _BackupManagerGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupManagerGoogleDriveCubit cubit = BlocProvider.of<BackupManagerGoogleDriveCubit>(context);
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
        buildWhen: (previous, current) => previous.code != current.code || previous.fileId != current.fileId,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                title: Text(appLocalizations.backupManagerGoogleDriveBackup),
                secondary: const Icon(Icons.cloud_rounded),
                value: state.code == BackupManagerGoogleDriveCode.idle,
                onChanged: cubit.setEnabled,
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today_rounded),
                title: Text(appLocalizations.backupManagerLastTime),
                subtitle: Text(DateTimeUtility.format(state.metadata?.modifiedTime, defaultValue: '-')),
              ),
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
                enabled: state.code == BackupManagerGoogleDriveCode.idle && state.fileId != null,
                future: cubit.restoreBackup,
              ),
              BackupManagerActionListTile(
                iconData: Icons.delete_outlined,
                titleLabel: appLocalizations.backupManagerDeleteBackup,
                successLabel: appLocalizations.backupManagerDeleteBackupSuccessfully,
                enabled: state.code == BackupManagerGoogleDriveCode.idle && state.fileId != null,
                future: cubit.deleteBackup,
                onComplete: cubit.refresh,
              ),
            ],
          );
        },
      ),
    );
  }
}
