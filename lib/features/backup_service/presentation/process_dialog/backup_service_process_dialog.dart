import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../main.dart';
import '../../domain/entities/backup_progress_step_code.dart';
import '../../domain/entities/backup_target_type.dart';
import '../../domain/entities/backup_task_type.dart';
import 'cubit/item_cubits/backup_service_process_bookmark_cubit.dart';
import 'cubit/item_cubits/backup_service_process_collection_cubit.dart';
import 'cubit/item_cubits/backup_service_process_library_cubit.dart';
import 'cubit/states/backup_service_process_item_state.dart';
import 'widgets/bookmark_tile.dart';

part 'widgets/close_button.dart';
part 'widgets/collection_tile.dart';
part 'widgets/library_tile.dart';

class BackupServiceProcessDialog extends StatelessWidget {
  const BackupServiceProcessDialog({
    super.key,
    required this.taskType,
    required this.targetType,
    this.libraryId,
    this.collectionId,
    this.bookmarkId,
  });

  final BackupTargetType targetType;
  final BackupTaskType taskType;
  final String? libraryId;
  final String? collectionId;
  final String? bookmarkId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<BackupServiceProcessLibraryCubit>(
          create: (_) => sl<BackupServiceProcessLibraryCubit>()
            ..startUp(taskType: taskType, targetType: targetType),
        ),
        BlocProvider<BackupServiceProcessBookmarkCubit>(
          create: (_) => BackupServiceProcessBookmarkCubit(
            googleDriveFileId: bookmarkId,
          )..startUp(taskType: taskType, targetType: targetType),
        ),
        BlocProvider<BackupServiceProcessCollectionCubit>(
          create: (_) => BackupServiceProcessCollectionCubit(
            googleDriveFileId: collectionId,
          )..startUp(taskType: taskType, targetType: targetType),
        ),
      ],
      child: const PopScope(
        canPop: false,
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _LibraryTile(),
                _CollectionTile(),
                BackupBookmarkTile(),
                _CloseButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
