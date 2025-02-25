import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../enum/loading_state_code.dart';
import '../../../generated/i18n/app_localizations.dart';
import '../../../preference_keys/preference_keys.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../repository/collection_repository.dart';
import '../../../utils/backup_utils.dart';
import '../../../utils/datetime_utils.dart';
import '../../../utils/google_drive_api.dart';
import '../../common_components/common_error_dialog.dart';
import '../../settings_page/settings_card.dart';
import '../backup_manager_process_all_dialog/backup_manager_process_all_dialog.dart';
import '../backup_manager_process_all_dialog/cubit/process_cubit.dart';

part 'bloc/cubit.dart';
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
      create: (_) => _Cubit(),
      child: SettingsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: childrenList,
        ),
      ),
    );
  }
}
