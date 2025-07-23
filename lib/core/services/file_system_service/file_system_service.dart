import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:novelglide/core/utils/random_extension.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'model/json_file_model.dart';
part 'repository/cache_repository.dart';
part 'repository/document_repository.dart';
part 'repository/file_path.dart';
part 'repository/json_repository.dart';
part 'repository/temp_repository.dart';

class FileSystemDomain {
  FileSystemDomain._();

  static CacheRepository cache = const CacheRepository();
  static DocumentRepository document = const DocumentRepository();
  static JsonRepository json = const JsonRepository();
  static FilePath path = const FilePath();
  static TempRepository temp = const TempRepository();
}
