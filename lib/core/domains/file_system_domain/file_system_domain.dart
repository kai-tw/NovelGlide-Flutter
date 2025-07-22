import 'dart:io';
import 'dart:math';

import 'package:novelglide/core/utils/random_extension.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'repository/cache_directory.dart';
part 'repository/document_directory.dart';
part 'repository/file_path.dart';
part 'repository/temp_directory.dart';

class FileSystemDomain {
  FileSystemDomain._();

  static CacheDirectory cache = CacheDirectory();
  static DocumentDirectory document = DocumentDirectory();
  static TempDirectory temp = TempDirectory();
  static FilePath path = FilePath();
}
