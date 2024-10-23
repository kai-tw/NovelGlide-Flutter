import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/loading_state_code.dart';
import '../bloc/backup_manager_google_drive_bloc.dart';

class BackupManagerGoogleDriveSwitcher extends StatelessWidget {
  const BackupManagerGoogleDriveSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BackupManagerGoogleDriveCubit>(context);
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
          title: Text(appLocalizations.backupManagerGoogleDrive),
          secondary: const Icon(Icons.cloud_rounded),
          value: state.code == LoadingStateCode.loaded,
          onChanged: (value) async {
            if (state.code == LoadingStateCode.loading) {
              return;
            }

            await cubit.setEnabled(value);
            await cubit.refresh();
          },
        );
      },
    );
  }
}
