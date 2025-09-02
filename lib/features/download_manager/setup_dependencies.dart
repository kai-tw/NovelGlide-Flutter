import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../core/file_system/domain/repositories/temp_repository.dart';
import '../../main.dart';
import 'data/data_sources/downloader_transmission_source.dart';
import 'data/data_sources/impl/mock_downloader_transmission_source.dart';
import 'data/repositories/downloader_repository_impl.dart';
import 'domain/repositories/downloader_repository.dart';
import 'domain/use_cases/downloader_clear_tasks_use_case.dart';
import 'domain/use_cases/downloader_download_file_use_case.dart';
import 'domain/use_cases/downloader_get_task_by_identifier_use_case.dart';
import 'domain/use_cases/downloader_get_task_list_use_case.dart';
import 'domain/use_cases/downloader_observe_task_list_change_use_case.dart';
import 'domain/use_cases/downloader_remove_task_use_case.dart';
import 'presentation/download_manager/cubit/download_manager_task_list_cubit.dart';
import 'presentation/download_manager/cubit/download_manager_task_list_item_cubit.dart';

void setupDownloaderDependencies() {
  // Register data sources
  // sl.registerLazySingleton<DownloaderTransmissionSource>(
  //   () => DownloaderTransmissionDioSource(),
  // );
  sl.registerLazySingleton<DownloaderTransmissionSource>(
    () => MockDownloaderTransmissionSource(),
  );

  // Register repositories
  sl.registerLazySingleton<DownloaderRepository>(
    () => DownloaderRepositoryImpl(
      sl<DownloaderTransmissionSource>(),
      sl<TempRepository>(),
      sl<FileSystemRepository>(),
    ),
  );

  // Register use cases
  sl.registerFactory<DownloaderClearTasksUseCase>(
    () => DownloaderClearTasksUseCase(
      sl<DownloaderRepository>(),
    ),
  );
  sl.registerFactory<DownloaderDownloadFileUseCase>(
    () => DownloaderDownloadFileUseCase(
      sl<DownloaderRepository>(),
    ),
  );
  sl.registerFactory<DownloaderGetTaskByIdentifierUseCase>(
    () => DownloaderGetTaskByIdentifierUseCase(
      sl<DownloaderRepository>(),
    ),
  );
  sl.registerFactory<DownloaderGetTaskListUseCase>(
    () => DownloaderGetTaskListUseCase(
      sl<DownloaderRepository>(),
    ),
  );
  sl.registerFactory<DownloaderObserveTaskListChangeUseCase>(
    () => DownloaderObserveTaskListChangeUseCase(
      sl<DownloaderRepository>(),
    ),
  );
  sl.registerFactory<DownloaderRemoveTaskUseCase>(
    () => DownloaderRemoveTaskUseCase(
      sl<DownloaderRepository>(),
    ),
  );

  // Register cubits
  sl.registerFactory<DownloadManagerTaskListCubit>(
    () => DownloadManagerTaskListCubit(
      sl<DownloaderGetTaskListUseCase>(),
      sl<DownloaderClearTasksUseCase>(),
      sl<DownloaderDownloadFileUseCase>(),
      sl<DownloaderObserveTaskListChangeUseCase>(),
    ),
  );
  sl.registerFactory<DownloadManagerTaskListItemCubit>(
    () => DownloadManagerTaskListItemCubit(
      sl<DownloaderGetTaskByIdentifierUseCase>(),
    ),
  );
}
