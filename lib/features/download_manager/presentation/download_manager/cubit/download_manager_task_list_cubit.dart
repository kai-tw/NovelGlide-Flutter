import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/use_cases/downloader_clear_tasks_use_case.dart';
import '../../../domain/use_cases/downloader_get_task_list_use_case.dart';
import '../../../domain/use_cases/downloader_observe_task_list_change_use_case.dart';
import 'download_manager_task_list_state.dart';

class DownloadManagerTaskListCubit extends Cubit<DownloadManagerTaskListState> {
  factory DownloadManagerTaskListCubit(
    DownloaderGetTaskListUseCase getTaskListUseCase,
    DownloaderClearTasksUseCase clearTasksUseCase,
    DownloaderObserveTaskListChangeUseCase observeTaskListChangeUseCase,
  ) {
    final DownloadManagerTaskListCubit cubit = DownloadManagerTaskListCubit._(
      getTaskListUseCase,
      clearTasksUseCase,
    );

    cubit._onListChangeSubscription =
        observeTaskListChangeUseCase().listen((_) => cubit.getTaskList());

    return cubit;
  }

  DownloadManagerTaskListCubit._(
    this._getTaskListUseCase,
    this._clearTasksUseCase,
  ) : super(const DownloadManagerTaskListState());

  /// Use cases
  final DownloaderGetTaskListUseCase _getTaskListUseCase;
  final DownloaderClearTasksUseCase _clearTasksUseCase;

  late final StreamSubscription<void> _onListChangeSubscription;

  bool _isGettingTaskList = false;

  Future<void> getTaskList() async {
    if (_isGettingTaskList) {
      return;
    }

    _isGettingTaskList = true;
    emit(const DownloadManagerTaskListState(
      code: LoadingStateCode.loading,
    ));

    final List<String> identifierList = await _getTaskListUseCase();
    _isGettingTaskList = false;

    if (!isClosed) {
      emit(DownloadManagerTaskListState(
        code: LoadingStateCode.loaded,
        identifierList: identifierList,
      ));
    }
  }

  Future<void> clearTasks() async {
    if (!state.code.isLoaded || state.identifierList.isEmpty) {
      return;
    }

    emit(const DownloadManagerTaskListState(
      code: LoadingStateCode.loading,
    ));
    await _clearTasksUseCase();
  }

  @override
  Future<void> close() async {
    _onListChangeSubscription.cancel();
    return super.close();
  }
}
