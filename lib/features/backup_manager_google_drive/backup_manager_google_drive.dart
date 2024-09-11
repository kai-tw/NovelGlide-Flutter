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
          BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              return SwitchListTile(
                title: Text(appLocalizations.backupManagerGoogleDriveBackup),
                secondary: const Icon(Icons.cloud_rounded),
                value: state.code == BackupManagerGoogleDriveCode.idle ||
                    state.code == BackupManagerGoogleDriveCode.creating ||
                    state.code == BackupManagerGoogleDriveCode.success,
                onChanged: state.code == BackupManagerGoogleDriveCode.idle ||
                        state.code == BackupManagerGoogleDriveCode.disabled
                    ? cubit.setEnabled
                    : null,
              );
            },
          ),
          BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const BackupManagerGoogleDriveFileManager()));
                },
                leading: const Icon(Icons.folder),
                title: Text(appLocalizations.backupManagerFileManagement),
                trailing: const Icon(Icons.chevron_right),
                enabled: state.code == BackupManagerGoogleDriveCode.idle,
              );
            },
          ),
          BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              switch (state.code) {
                case BackupManagerGoogleDriveCode.disabled:
                case BackupManagerGoogleDriveCode.idle:
                  return ListTile(
                    leading: const Icon(Icons.add),
                    title: Text(appLocalizations.backupManagerCreateNewBackup),
                    onTap: () => cubit.createBackup(),
                    enabled: state.code == BackupManagerGoogleDriveCode.idle,
                  );

                case BackupManagerGoogleDriveCode.creating:
                  return ListTile(
                    leading: const Icon(Icons.sync),
                    title: Text(appLocalizations.backupManagerCreateNewBackup),
                    enabled: false,
                  );

                case BackupManagerGoogleDriveCode.success:
                  return ListTile(
                    leading: const Icon(Icons.check_rounded),
                    title: Text(appLocalizations.backupManagerCreateNewBackup),
                    iconColor: Colors.green,
                    textColor: Colors.green,
                  );

                case BackupManagerGoogleDriveCode.error:
                  return ListTile(
                    leading: const Icon(Icons.close_rounded),
                    title: Text(appLocalizations.backupManagerCreateNewBackup),
                    iconColor: Theme.of(context).colorScheme.error,
                    textColor: Theme.of(context).colorScheme.error,
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
