import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';

import '../../../path_provider/domain/repositories/app_path_provider.dart';
import '../../../use_cases/use_case.dart';
import '../../../utils/random_extension.dart';
import '../repositories/file_system_repository.dart';

class CreateTemporaryDirectoryUseCase extends UseCase<Future<Directory>, void> {
  const CreateTemporaryDirectoryUseCase(this._pathProvider, this._repository);

  final AppPathProvider _pathProvider;
  final FileSystemRepository _repository;

  @override
  Future<Directory> call([void parameter]) async {
    final String root = await _pathProvider.tempPath;
    String path;

    do {
      path = join(root, Random().nextString(8));
    } while (await _repository.existsDirectory(path));

    return _repository.createDirectory(path);
  }
}
