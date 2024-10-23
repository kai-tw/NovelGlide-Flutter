import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/loading_state_code.dart';
import '../../../toolbox/datetime_utility.dart';
import '../bloc/backup_manager_google_drive_bloc.dart';

class BackupManagerGoogleDriveTimeTile extends StatelessWidget {
  const BackupManagerGoogleDriveTimeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<BackupManagerGoogleDriveCubit,
        BackupManagerGoogleDriveState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final isLoading = state.code == LoadingStateCode.loading;
        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
          leading: const Icon(Icons.calendar_today_rounded),
          title: Text(appLocalizations.backupManagerLastTime),
          subtitle: Text(
            DateTimeUtility.format(
              state.lastBackupTime,
              defaultValue: '-',
            ),
          ),
          trailing: isLoading ? const CircularProgressIndicator() : null,
        );
      },
    );
  }
}
