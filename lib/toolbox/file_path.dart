import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// A utility class for managing file paths in the application.
class FilePath {
  // Private constructor to prevent instantiation.
  FilePath._();

  /// Shared folders

  /// Returns the path to the application support directory.
  static Future<String> get supportFolder async =>
      (await getApplicationSupportDirectory()).path;

  /// Returns the path to the application documents directory.
  static Future<String> get documentFolder async =>
      (await getApplicationDocumentsDirectory()).path;

  /// Returns the path to the application cache directory.
  static Future<String> get cacheFolder async =>
      (await getApplicationCacheDirectory()).path;

  /// Returns the path to the temporary directory.
  static Future<String> get tempFolder async =>
      (await getTemporaryDirectory()).path;

  /// Returns the path to the downloads directory, if available.
  static Future<String?> get downloadFolder async =>
      (await getDownloadsDirectory())?.path;

  /// Platform-specific folders

  /// Returns the path to the iOS library directory, if on iOS.
  static Future<String?> get _iosLibraryFolder async =>
      Platform.isIOS ? (await getLibraryDirectory()).path : null;

  /// Application folders

  /// Returns the base folder path, preferring iOS library on iOS.
  static Future<String> get _baseFolder async =>
      await _iosLibraryFolder ?? await documentFolder;

  /// Returns the path to the library root directory.
  static Future<String> get libraryRoot async =>
      join(await _baseFolder, 'Library');

  /// Returns the path to the data root directory.
  static Future<String> get dataRoot async => join(await _baseFolder, 'Data');
}
