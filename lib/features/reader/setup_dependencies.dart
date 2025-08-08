import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../main.dart';
import '../books/domain/use_cases/get_book_use_case.dart';
import 'data/repositories/reader_server_repository_impl.dart';
import 'domain/repositories/reader_server_repository.dart';
import 'presentation/reader_page/cubit/reader_cubit.dart';

void setupReaderDependencies() {
  // Register repositories
  sl.registerLazySingleton<ReaderServerRepository>(
      () => ReaderServerRepositoryImpl(sl<FileSystemRepository>()));

  // Register factories
  sl.registerFactory<ReaderCubit>(
      () => ReaderCubit(sl<FileSystemRepository>(), sl<GetBookUseCase>()));
}
