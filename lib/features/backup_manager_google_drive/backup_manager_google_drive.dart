import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'backup_manager_google_drive_file_manager.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(Icons.cloud_rounded),
            title: Text(appLocalizations.backupManagerGoogleDriveBackup),
            trailing: BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
              buildWhen: (previous, current) => previous.isEnabled != current.isEnabled,
              builder: (context, state) {
                return Semantics(
                  label: state.isEnabled
                      ? appLocalizations.backupManagerGoogleDriveBackupEnable
                      : appLocalizations.backupManagerGoogleDriveBackupDisable,
                  value: state.isEnabled ? appLocalizations.generalEnabled : appLocalizations.generalDisabled,
                  child: Switch(
                    value: state.isEnabled,
                    onChanged: cubit.setEnabled,
                  ),
                );
              },
            ),
          ),
          BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) =>
                previous.isEnabled != current.isEnabled || previous.createState != current.createState,
            builder: (context, state) {
              return ListTile(
                onTap: () {
                  if (state.isEnabled) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const BackupManagerGoogleDriveFileManager()));
                  }
                },
                leading: const Icon(Icons.folder),
                title: Text(appLocalizations.backupManagerFileManagement),
                trailing: const Icon(Icons.chevron_right),
                iconColor: Theme.of(context).colorScheme.primary.withOpacity(state.isEnabled ? 1 : 0.5),
                textColor: Theme.of(context).colorScheme.primary.withOpacity(state.isEnabled ? 1 : 0.5),
              );
            },
          ),
          BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) =>
                previous.isEnabled != current.isEnabled || previous.createState != current.createState,
            builder: (context, state) {
              Future<void> Function()? onTap;
              IconData leadingIcon;
              Color color;

              if (state.isEnabled) {
                switch (state.createState) {
                  case BackupManagerGoogleDriveCreateState.idle:
                    onTap = () => cubit.createBackup();
                    leadingIcon = Icons.cloud_upload_rounded;
                    color = Theme.of(context).colorScheme.primary.withOpacity(1);
                    break;

                  case BackupManagerGoogleDriveCreateState.creating:
                    leadingIcon = Icons.cloud_sync_rounded;
                    color = Theme.of(context).colorScheme.primary.withOpacity(0.5);
                    break;

                  case BackupManagerGoogleDriveCreateState.success:
                    leadingIcon = Icons.cloud_done_rounded;
                    color = Colors.green;
                    break;

                  case BackupManagerGoogleDriveCreateState.failed:
                    leadingIcon = Icons.cloud_off_rounded;
                    color = Theme.of(context).colorScheme.error;
                    break;
                }
              } else {
                onTap = null;
                leadingIcon = Icons.cloud_off_rounded;
                color = Theme.of(context).colorScheme.primary.withOpacity(0.5);
              }

              return ListTile(
                onTap: onTap,
                leading: Icon(leadingIcon),
                title: Text(appLocalizations.backupManagerCreateNewBackup),
                iconColor: color,
                textColor: color,
              );
            },
          ),
        ],
      ),
    );
  }
}
