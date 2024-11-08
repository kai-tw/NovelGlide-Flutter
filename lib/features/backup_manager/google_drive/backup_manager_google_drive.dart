import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data_model/preference_keys.dart';
import '../../../enum/loading_state_code.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../repository/collection_repository.dart';
import '../../../utils/backup_utils.dart';
import '../../../utils/datetime_utils.dart';
import '../../../utils/google_drive_api.dart';
import '../../../utils/random_utils.dart';
import '../../common_components/common_error_dialog.dart';
import '../../common_components/common_loading.dart';
import '../../common_components/common_success_dialog.dart';

part 'bloc/backup_book_process_cubit.dart';
part 'bloc/cubit.dart';
part 'bloc/process_dialog_state.dart';
part 'dialog/backup_book_process_dialog.dart';
part 'widgets/backup_all_list_tile.dart';
part 'widgets/backup_book_list_tile.dart';
part 'widgets/backup_bookmark_list_tile.dart';
part 'widgets/backup_collection_list_tile.dart';
part 'widgets/buttons/backup_book_button.dart';
part 'widgets/buttons/delete_book_button.dart';
part 'widgets/buttons/restore_book_button.dart';
part 'widgets/switch_list_tile.dart';
part 'widgets/time_list_tile.dart';
part 'widgets/utils/dialog_builder.dart';

class BackupManagerGoogleDrive extends StatelessWidget {
  const BackupManagerGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _Cubit(),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(24.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: const Column(
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
