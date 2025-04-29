import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../enum/loading_state_code.dart';
import '../../../exceptions/exceptions.dart';
import '../../../generated/i18n/app_localizations.dart';
import '../../../utils/datetime_utils.dart';
import '../../common_components/common_error_dialog.dart';
import '../../settings_page/settings_card.dart';
import '../backup_service_process_dialog/backup_service_process_dialog.dart';
import '../cubit/backup_service_process_cubit.dart';
import 'cubit/backup_service_google_drive_cubit.dart';

part 'widgets/action_button.dart';
part 'widgets/switch_list_tile.dart';
part 'widgets/target_type_tile.dart';
part 'widgets/time_list_tile.dart';

class BackupServiceGoogleDrive extends StatelessWidget {
  const BackupServiceGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final List<String> titleList = <String>[
      appLocalizations.backupManagerLabelAll,
      appLocalizations.backupManagerLabelLibrary,
      appLocalizations.backupManagerLabelCollection,
      appLocalizations.backupManagerLabelBookmark,
    ];
    final List<StatelessWidget> childrenList = <StatelessWidget>[
      const _SwitchListTile(),
      const _TimeListTile(),
      const Divider(),
    ];

    for (int i = 0; i < titleList.length; i++) {
      childrenList.add(
        _TargetTypeTile(
          title: titleList[i],
          children: BackupServiceTaskType.values
              .map(
                (BackupServiceTaskType taskType) => _ActionButton(
                  targetType: BackupServiceTargetType.values[i],
                  taskType: taskType,
                ),
              )
              .toList(),
        ),
      );
    }

    return BlocProvider<BackupServiceGoogleDriveCubit>(
      create: (_) => BackupServiceGoogleDriveCubit(),
      child: SettingsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: childrenList,
        ),
      ),
    );
  }
}
