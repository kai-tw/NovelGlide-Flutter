import '../../main.dart';
import '../books/domain/use_cases/book_get_use_case.dart';
import '../books/domain/use_cases/book_read_bytes_use_case.dart';
import 'presentation/reader_page/cubit/reader_cubit.dart';

void setupReaderDependencies() {
  // Register factories
  sl.registerFactory<ReaderCubit>(
      () => ReaderCubit(sl<BookReadBytesUseCase>(), sl<BookGetUseCase>()));
}
