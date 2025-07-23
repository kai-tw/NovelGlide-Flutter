part of '../file_system_service.dart';

/// A utility class for managing file paths in the application.
class FilePath {
  const FilePath();

  FilePath._();

  /// Shared folders
  // static late String supportFolder;
  static late String documentFolder;

  // static late String cacheFolder;

  // static String? downloadFolder;

  /// Platform-specific folders
  static String? _iosLibraryFolder;

  /// Application folders
  static String get _baseFolder => _iosLibraryFolder ?? documentFolder;

  static String get libraryRoot => join(_baseFolder, 'Library');

  static String get dataRoot => join(_baseFolder, 'Data');

  static Future<void> ensureInitialized() async {
    final List<Future<void>> tasks = <Future<void>>[
      getApplicationDocumentsDirectory()
          .then((Directory dir) => documentFolder = dir.path),
      // getApplicationSupportDirectory().then((Directory dir) => supportFolder = dir.path),
      // getApplicationCacheDirectory().then((Directory dir) => cacheFolder = dir.path),
      // getDownloadsDirectory().then((Directory? dir) => downloadFolder = dir?.path),
    ];

    if (Platform.isIOS) {
      tasks.add(getLibraryDirectory()
          .then((Directory? dir) => _iosLibraryFolder = dir?.path));
    }

    await Future.wait<void>(tasks);

    // Create the folders if they don't exist.
    for (final String folderPath in <String>[libraryRoot, dataRoot]) {
      final Directory folder = Directory(folderPath);
      if (!folder.existsSync()) {
        folder.createSync(recursive: true);
      }
    }
  }
}
