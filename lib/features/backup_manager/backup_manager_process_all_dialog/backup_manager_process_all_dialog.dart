import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import 'cubit/process_cubit.dart';

part 'widgets/bookmark_tile.dart';
part 'widgets/close_button.dart';
part 'widgets/collection_tile.dart';
part 'widgets/library_tile.dart';

class BackupManagerProcessAllDialog extends StatelessWidget {
  final BackupManagerTargetType targetType;
  final BackupManagerTaskType taskType;
  final String libraryId;
  final String collectionId;
  final String bookmarkId;

  const BackupManagerProcessAllDialog({
    super.key,
    required this.taskType,
    required this.targetType,
    required this.libraryId,
    required this.collectionId,
    required this.bookmarkId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProcessAllDialogCubit(
        libraryId: libraryId,
        collectionId: collectionId,
        bookmarkId: bookmarkId,
      )..start(taskType, targetType),
      child: const PopScope(
        canPop: false,
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
