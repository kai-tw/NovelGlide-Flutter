import '../entities/mime_type.dart';

abstract class MimeRepository {
  Future<MimeType?> lookupAll(String path);
}
