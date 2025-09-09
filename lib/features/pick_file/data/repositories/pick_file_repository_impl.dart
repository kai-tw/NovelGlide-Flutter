import '../../domain/repositories/pick_file_repository.dart';
import '../data_sources/pick_file_local_data_source.dart';

class PickFileRepositoryImpl implements PickFileRepository {
  PickFileRepositoryImpl(this._localDataSource);

  final PickFileLocalDataSource _localDataSource;

  @override
  Future<void> clearTemporaryFiles() {
    return _localDataSource.clearTemporaryFiles();
  }

  @override
  Future<Set<String>> pickFiles({
    required List<String> allowedExtensions,
  }) {
    return _localDataSource.pickFiles(
      allowedExtensions: allowedExtensions,
    );
  }
}
