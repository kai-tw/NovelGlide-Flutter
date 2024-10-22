import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// A utility class for managing file paths in the application.
class FilePath {
  /// Shared folders
  // static late String supportFolder;
  static late String documentFolder;
  // static late String cacheFolder;
  static late String tempFolder;
  // static String? downloadFolder;

  /// Platform-specific folders
  static String? _iosLibraryFolder;

  /// Application folders
  static String get _baseFolder => _iosLibraryFolder ?? documentFolder;
  static String get libraryRoot => join(_baseFolder, 'Library');
  static String get dataRoot => join(_baseFolder, 'Data');

  // Private constructor to prevent instantiation.
  FilePath._();

  static Future<void> ensureInitialized() async {
    // supportFolder = (await getApplicationSupportDirectory()).path;
    documentFolder = (await getApplicationDocumentsDirectory()).path;
    // cacheFolder = (await getApplicationCacheDirectory()).path;
    tempFolder = (await getTemporaryDirectory()).path;
    // downloadFolder = (await getDownloadsDirectory())?.path;
    _iosLibraryFolder =
        Platform.isIOS ? (await getLibraryDirectory()).path : null;

    // Create the folders if they don't exist.
    for (final folderPath in [libraryRoot, dataRoot]) {
      final folder = Directory(folderPath);
      if (!folder.existsSync()) {
        folder.createSync(recursive: true);
      }
    }
  }
}
