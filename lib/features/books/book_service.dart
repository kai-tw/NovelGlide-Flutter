import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';

import '../../core/services/file_system_service/file_system_service.dart';
import '../../core/services/mime_resolver.dart';

part 'data/repository/book_repository_old.dart';

class BookService {
  BookService._();

  static final BookRepositoryOld repository = BookRepositoryOld();
}
