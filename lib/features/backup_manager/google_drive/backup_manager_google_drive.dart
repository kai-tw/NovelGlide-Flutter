import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/loading_state_code.dart';
import '../../../exceptions/exceptions.dart';
import '../../../generated/i18n/app_localizations.dart';
import '../../../utils/datetime_utils.dart';
import '../../common_components/common_error_dialog.dart';
import '../../settings_page/settings_card.dart';
import '../backup_manager_process_all_dialog/backup_manager_process_all_dialog.dart';
import '../backup_manager_process_all_dialog/cubit/process_cubit.dart';
import 'cubit/backup_manager_google_drive_cubit.dart';

part 'widgets/action_button.dart';
part 'widgets/switch_list_tile.dart';
part 'widgets/target_type_tile.dart';
part 'widgets/time_list_tile.dart';

class BackupManagerGoogleDrive extends StatelessWidget {
  const BackupManagerGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final titleList = [
      appLocalizations.backupManagerLabelAll,
      appLocalizations.backupManagerLabelLibrary,
      appLocalizations.backupManagerLabelCollection,
      appLocalizations.backupManagerLabelBookmark,
    ];
    final childrenList = [
      const _SwitchListTile(),
      const _TimeListTile(),
      const Divider(),
    ];

    for (int i = 0; i < titleList.length; i++) {
      childrenList.add(
        _TargetTypeTile(
          title: titleList[i],
          children: BackupManagerTaskType.values
              .map(
                (taskType) => _ActionButton(
                  targetType: BackupManagerTargetType.values[i],
                  taskType: taskType,
                ),
              )
              .toList(),
        ),
      );
    }

    return BlocProvider(
      create: (_) => BackupManagerGoogleDriveCubit(),
      child: SettingsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: childrenList,
        ),
      ),
    );
  }
}
