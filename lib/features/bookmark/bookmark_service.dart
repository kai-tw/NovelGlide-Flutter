import 'dart:async';

import '../../core/services/file_system_service/file_system_service.dart';
import 'domain/entities/bookmark_data.dart';

part 'data/bookmark_repository_old.dart';

class BookmarkService {
  BookmarkService._();

  static BookmarkRepositoryOld repository = BookmarkRepositoryOld();
}
