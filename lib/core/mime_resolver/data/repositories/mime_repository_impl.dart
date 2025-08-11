import '../../domain/repositories/mime_repository.dart';
import '../data_sources/mime_local_source.dart';

class MimeRepositoryImpl implements MimeRepository {
  MimeRepositoryImpl(this._localSource);

  final MimeLocalSource _localSource;

  @override
  Future<String?> lookupAll(String path) {
    return _localSource.lookupAll(path);
  }
}
