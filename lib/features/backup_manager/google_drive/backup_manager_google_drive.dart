import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../enum/loading_state_code.dart';
import '../../../preference_keys/preference_keys.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../repository/collection_repository.dart';
import '../../../utils/backup_utils.dart';
import '../../../utils/datetime_utils.dart';
import '../../../utils/google_drive_api.dart';
import '../../../utils/random_utils.dart';
import '../../common_components/common_error_dialog.dart';
import '../../settings_page/settings_card.dart';

part 'bloc/cubit.dart';
part 'bloc/process_cubit.dart';
part 'dialog/process_all_dialog/process_all_bookmark_tile.dart';
part 'dialog/process_all_dialog/process_all_button_bar.dart';
part 'dialog/process_all_dialog/process_all_collection_tile.dart';
part 'dialog/process_all_dialog/process_all_dialog.dart';
part 'dialog/process_all_dialog/process_all_library_tile.dart';
part 'widgets/backup_all_list_tile.dart';
part 'widgets/backup_book_list_tile.dart';
part 'widgets/backup_bookmark_list_tile.dart';
part 'widgets/backup_collection_list_tile.dart';
part 'widgets/buttons/backup_all_button.dart';
part 'widgets/buttons/backup_book_button.dart';
part 'widgets/buttons/backup_bookmark_button.dart';
part 'widgets/buttons/backup_collection_button.dart';
part 'widgets/buttons/delete_all_button.dart';
part 'widgets/buttons/delete_book_button.dart';
part 'widgets/buttons/delete_bookmark_button.dart';
part 'widgets/buttons/delete_collection_button.dart';
part 'widgets/buttons/restore_all_button.dart';
part 'widgets/buttons/restore_book_button.dart';
part 'widgets/buttons/restore_bookmark_button.dart';
part 'widgets/buttons/restore_collection_button.dart';
part 'widgets/switch_list_tile.dart';
part 'widgets/time_list_tile.dart';

class BackupManagerGoogleDrive extends StatelessWidget {
  const BackupManagerGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _Cubit(),
      child: const SettingsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SwitchListTile(),
            _TimeListTile(),
            Divider(),
            _BackupAllListTile(),
            _BackupBookListTile(),
            _BackupCollectionListTile(),
            _BackupBookmarkListTile(),
          ],
        ),
      ),
    );
  }
}
