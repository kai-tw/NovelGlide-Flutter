import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/use_cases/downloader_clear_tasks_use_case.dart';
import '../../../domain/use_cases/downloader_get_task_list_use_case.dart';
import 'download_manager_state.dart';

class DownloadManagerCubit extends Cubit<DownloadManagerState> {
  DownloadManagerCubit(
    this._getTaskListUseCase,
    this._clearTasksUseCase,
  ) : super(const DownloadManagerState());

  /// Use cases
  final DownloaderGetTaskListUseCase _getTaskListUseCase;
  final DownloaderClearTasksUseCase _clearTasksUseCase;

  Future<void> getTaskList() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    emit(const DownloadManagerState(
      code: LoadingStateCode.loading,
    ));

    final List<String> identifierList = await _getTaskListUseCase();

    if (!isClosed) {
      emit(DownloadManagerState(
        code: LoadingStateCode.loaded,
        identifierList: identifierList,
      ));
    }
  }

  Future<void> clearTasks() async {
    if (!state.code.isLoaded || state.identifierList.isEmpty) {
      return;
    }

    emit(const DownloadManagerState(
      code: LoadingStateCode.loading,
    ));
    await _clearTasksUseCase();
    await getTaskList();
  }
}
