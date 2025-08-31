import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../core/file_system/domain/repositories/temp_repository.dart';
import '../../main.dart';
import 'data/data_sources/downloader_transmission_source.dart';
import 'data/data_sources/impl/downloader_transmission_dio_source.dart';
import 'data/repositories/downloader_repository_impl.dart';
import 'domain/repositories/downloader_repository.dart';
import 'domain/use_cases/downloader_clear_tasks_use_case.dart';
import 'domain/use_cases/downloader_download_file_use_case.dart';
import 'domain/use_cases/downloader_get_task_list_use_case.dart';
import 'domain/use_cases/downloader_remove_task_use_case.dart';
import 'presentation/downloader_list/cubit/download_manager_cubit.dart';

void setupDownloaderDependencies() {
  // Register data sources
  sl.registerLazySingleton<DownloaderTransmissionSource>(
    () => DownloaderTransmissionDioSource(),
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
  sl.registerFactory<DownloaderGetTaskListUseCase>(
    () => DownloaderGetTaskListUseCase(
      sl<DownloaderRepository>(),
    ),
  );
  sl.registerFactory<DownloaderRemoveTaskUseCase>(
    () => DownloaderRemoveTaskUseCase(
      sl<DownloaderRepository>(),
    ),
  );

  // Register cubits
  sl.registerFactory<DownloadManagerCubit>(
    () => DownloadManagerCubit(
      sl<DownloaderGetTaskListUseCase>(),
      sl<DownloaderClearTasksUseCase>(),
    ),
  );
}
