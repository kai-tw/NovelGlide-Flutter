import '../../../../core/domain/use_cases/use_case.dart';
import '../../../download_manager/domain/entities/downloader_task.dart';
import '../../../download_manager/domain/use_cases/downloader_download_file_use_case.dart';
import 'book_add_use_case.dart';

class BookDownloadAndAddUseCaseParam {
  BookDownloadAndAddUseCaseParam({
    required this.uri,
    required this.name,
  });

  final Uri uri;
  final String name;
}

class BookDownloadAndAddUseCase
    extends UseCase<Future<void>, BookDownloadAndAddUseCaseParam> {
  BookDownloadAndAddUseCase(
    this._downloadFileUseCase,
    this._addBookUseCase,
  );

  final DownloaderDownloadFileUseCase _downloadFileUseCase;
  final BookAddUseCase _addBookUseCase;

  @override
  Future<void> call(BookDownloadAndAddUseCaseParam parameter) async {
    await _downloadFileUseCase(DownloaderDownloadFileUseCaseParam(
      uri: parameter.uri,
      name: parameter.name,
      onSuccess: (DownloaderTask task) async {
        // Add to bookshelf
        await _addBookUseCase(<String>{task.savePath});
      },
    ));
  }
}
