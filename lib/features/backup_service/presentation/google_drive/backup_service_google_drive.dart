import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/exceptions.dart';
import '../../../../core/utils/datetime_utils.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../common_components/common_error_dialog.dart';
import '../../../settings_page/settings_card.dart';
import '../process_dialog/backup_service_process_dialog.dart';
import '../process_dialog/cubit/backup_service_process_cubit.dart';
import 'cubit/backup_service_google_drive_cubit.dart';

part 'widgets/backup_service_google_drive_action_button.dart';
part 'widgets/backup_service_google_drive_switch_list_tile.dart';
part 'widgets/backup_service_google_drive_target_tile.dart';
part 'widgets/backup_service_google_drive_time_tile.dart';

class BackupServiceGoogleDrive extends StatelessWidget {
  const BackupServiceGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BackupServiceGoogleDriveCubit>(
      create: (_) => BackupServiceGoogleDriveCubit(),
      child: SettingsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const BackupServiceGoogleDriveSwitchListTile(),
            const BackupServiceGoogleDriveTimeTile(),
            const Divider(),
            ...BackupServiceTargetType.values.map<Widget>(
              (BackupServiceTargetType targetType) =>
                  BackupServiceGoogleDriveTargetTile(targetType: targetType),
            ),
          ],
        ),
      ),
    );
  }
}
