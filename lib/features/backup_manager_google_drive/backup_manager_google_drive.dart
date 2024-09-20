import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/route_helper.dart';
import '../common_components/common_loading.dart';
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
      child: BlocBuilder<BackupManagerGoogleDriveCubit, BackupManagerGoogleDriveState>(
        buildWhen: (previous, current) => previous.code != current.code,
        builder: (context, state) {
          String createButtonText;

          switch (state.code) {
            case BackupManagerGoogleDriveCode.idle:
              createButtonText = appLocalizations.backupManagerCreateNewBackup;
              break;
            case BackupManagerGoogleDriveCode.creating:
              createButtonText = appLocalizations.backupManagerCreating;
              break;
            case BackupManagerGoogleDriveCode.success:
              createButtonText = appLocalizations.backupManagerCreationSuccess;
              break;
            default:
              createButtonText = appLocalizations.backupManagerCreationError;
          }

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
                onTap: () {
                  Navigator.of(context).push(RouteHelper.pushRoute(const BackupManagerGoogleDriveFileManager()));
                },
                leading: const Icon(Icons.folder),
                title: Text(appLocalizations.backupManagerFileManagement),
                trailing: const Icon(Icons.chevron_right),
                enabled: state.code == BackupManagerGoogleDriveCode.idle,
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: Text(createButtonText),
                enabled: state.code == BackupManagerGoogleDriveCode.idle,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return FutureBuilder(
                        future: cubit.createBackup(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AlertDialog(
                              icon: const Icon(Icons.check_rounded, color: Colors.green, size: 60.0),
                              content: Text(appLocalizations.backupManagerCreationSuccess),
                              actions: [
                                TextButton.icon(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.close_rounded),
                                  label: Text(appLocalizations.generalClose),
                                ),
                              ],
                            );
                          } else {
                            return const AlertDialog(
                              content: SizedBox(
                                width: 200.0,
                                height: 100.0,
                                child: CommonLoading(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
