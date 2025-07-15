import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../backup_service.dart';

part 'widgets/bookmark_tile.dart';
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

  final BackupServiceTargetType targetType;
  final BackupServiceTaskType taskType;
  final String? libraryId;
  final String? collectionId;
  final String? bookmarkId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<BackupServiceProcessLibraryCubit>(
          create: (_) => BackupServiceProcessLibraryCubit(
            googleDriveFileId: libraryId,
          )..startUp(taskType: taskType, targetType: targetType),
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
                _BookmarkTile(),
                _CloseButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
