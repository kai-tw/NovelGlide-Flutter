import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:novelglide/core/utils/random_extension.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/book_service/book_service.dart';

part 'model/file_meta_model.dart';
part 'model/json_file_meta_model.dart';
part 'repository/cache_repository.dart';
part 'repository/document_repository.dart';
part 'repository/epub_repository.dart';
part 'repository/file_system_repository.dart';
part 'repository/json_repository.dart';
part 'repository/temp_repository.dart';

class FileSystemService {
  FileSystemService._();

  static CacheRepository cache = const CacheRepository();
  static DocumentRepository document = const DocumentRepository();
  static EpubRepository epub = const EpubRepository();
  static JsonRepository json = const JsonRepository();
  static TempRepository temp = const TempRepository();
}
