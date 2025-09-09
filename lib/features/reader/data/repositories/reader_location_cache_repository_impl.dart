import 'package:path/path.dart';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/path_provider/domain/repositories/app_path_provider.dart';
import '../../domain/repositories/reader_location_cache_repository.dart';

class ReaderLocationCacheRepositoryImpl extends ReaderLocationCacheRepository {
  ReaderLocationCacheRepositoryImpl(
    this._appPathProvider,
    this._fileSystemRepository,
  );

  final AppPathProvider _appPathProvider;
  final FileSystemRepository _fileSystemRepository;

  Future<String> _getTmpPathByIdentifier(String bookIdentifier) async {
    return join(
        await _appPathProvider.bookLocationCachePath, '$bookIdentifier.tmp');
  }

  @override
  Future<void> clear() async {
    await _fileSystemRepository
        .deleteDirectory(await _appPathProvider.bookLocationCachePath);
    await _fileSystemRepository
        .createDirectory(await _appPathProvider.bookLocationCachePath);
  }

  @override
  Future<void> delete(Set<String> bookIdentifierSet) async {
    for (String bookIdentifier in bookIdentifierSet) {
      final String path = await _getTmpPathByIdentifier(bookIdentifier);
      await _fileSystemRepository.deleteFile(path);
    }
  }

  @override
  Future<String?> get(String bookIdentifier) async {
    final String path = await _getTmpPathByIdentifier(bookIdentifier);
    if (await _fileSystemRepository.existsFile(path)) {
      return _fileSystemRepository.readFileAsString(path);
    } else {
      return null;
    }
  }

  @override
  Future<void> store(String bookIdentifier, String location) async {
    final String path = await _getTmpPathByIdentifier(bookIdentifier);
    await _fileSystemRepository.writeFileAsString(path, location);
  }
}
