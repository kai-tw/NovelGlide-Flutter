import 'dart:math';

import 'package:path/path.dart';

import '../../../../core/utils/random_extension.dart';
import '../../../path_provider/domain/repositories/app_path_provider.dart';
import '../../domain/repositories/file_system_repository.dart';
import '../../domain/repositories/temp_repository.dart';

class TempRepositoryImpl implements TempRepository {
  TempRepositoryImpl(this._pathProvider, this._fileSystemRepository);

  final AppPathProvider _pathProvider;
  final FileSystemRepository _fileSystemRepository;

  @override
  Future<String> getDirectoryPath() async {
    final String root = await _pathProvider.tempPath;
    String path;

    do {
      path = join(root, Random().nextString(8));
    } while (await _fileSystemRepository.existsDirectory(path));

    await _fileSystemRepository.createDirectory(path);
    return path;
  }
}
