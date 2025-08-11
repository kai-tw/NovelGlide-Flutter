import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/exception_service/exception_service.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../../main.dart';
import '../../../locale_system/locale_utils.dart';
import '../../../settings_page/presentation/widgets/settings_card.dart';
import '../../domain/entities/backup_target_type.dart';
import '../../domain/entities/backup_task_type.dart';
import '../process_dialog/backup_service_process_dialog.dart';
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
      create: (_) => sl<BackupServiceGoogleDriveCubit>()..refresh(),
      child: SettingsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const BackupServiceGoogleDriveSwitchListTile(),
            const BackupServiceGoogleDriveTimeTile(),
            const Divider(),
            ...BackupTargetType.values.map<Widget>(
              (BackupTargetType targetType) =>
                  BackupServiceGoogleDriveTargetTile(targetType: targetType),
            ),
          ],
        ),
      ),
    );
  }
}
