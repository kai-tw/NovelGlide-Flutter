import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../domain/entities/downloader_task.dart';
import '../../../domain/entities/downloader_task_state.dart';
import '../../../domain/use_cases/downloader_get_task_by_identifier_use_case.dart';
import '../../../domain/use_cases/downloader_remove_task_use_case.dart';
import 'download_manager_task_list_item_state.dart';

class DownloadManagerTaskListItemCubit
    extends Cubit<DownloadManagerTaskListItemState> {
  DownloadManagerTaskListItemCubit(
    this._getTaskByIdentifierUseCase,
    this._removeTaskUseCase,
  ) : super(const DownloadManagerTaskListItemState());

  final DownloaderGetTaskByIdentifierUseCase _getTaskByIdentifierUseCase;
  final DownloaderRemoveTaskUseCase _removeTaskUseCase;

  late final String _identifier;
  StreamSubscription<double>? _progressSubscription;

  Future<void> init(String identifier) async {
    _identifier = identifier;
    final DownloaderTask? task = await _getTaskByIdentifierUseCase(identifier);

    if (task == null) {
      // This task is not existed.
      emit(state.copyWith(
        stateCode: DownloaderTaskState.error,
      ));
    } else {
      emit(state.copyWith(
        stateCode: task.stateCode,
        fileName: basename(task.savePath),
        startTime: task.startTime,
      ));

      _progressSubscription = task.onDownloadStream.listen(
        (double progress) {
          emit(state.copyWith(
            progress: progress,
          ));
        },
        onDone: () {
          emit(state.copyWith(
            stateCode: DownloaderTaskState.success,
          ));
        },
        onError: (_) {
          emit(state.copyWith(
            stateCode: DownloaderTaskState.error,
          ));
        },
      );
    }
  }

  Future<void> cancelTask() async {
    await _removeTaskUseCase(_identifier);
  }

  @override
  Future<void> close() async {
    _progressSubscription?.cancel();
    return super.close();
  }
}
