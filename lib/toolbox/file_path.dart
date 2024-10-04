import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FilePath {
  FilePath._();

  /// Shared folders

  static Future<String> get supportFolder async => (await getApplicationSupportDirectory()).path;

  static Future<String> get documentFolder async => (await getApplicationDocumentsDirectory()).path;

  static Future<String> get cacheFolder async => (await getApplicationCacheDirectory()).path;

  static Future<String> get tempFolder async => (await getTemporaryDirectory()).path;

  static Future<String?> get downloadFolder async => (await getDownloadsDirectory())?.path;

  /// Platform only folders

  static Future<String?> get _iosLibraryFolder async => Platform.isIOS ? (await getLibraryDirectory()).path : null;

  /// Application folders

  static Future<String> get _baseFolder async => await _iosLibraryFolder ?? await documentFolder;

  static Future<String> get libraryRoot async => join(await _baseFolder, 'Library');

  static Future<String> get dataRoot async => join(await _baseFolder, 'Data');
}
