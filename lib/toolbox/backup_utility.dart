import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/bookmark_data.dart';
import '../data/collection_data.dart';
import 'file_path.dart';
import '../data/preference_keys.dart';

class BackupUtility {
  static Future<File> createBackup(String tempFolderPath) async {
    // Read the backup settings
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isBackupCollections = prefs.getBool(PreferenceKeys.backupManager.isBackupCollections) ?? false;
    final isBackupBookmarks = prefs.getBool(PreferenceKeys.backupManager.isBackupBookmarks) ?? false;

    final String libraryRoot = await FilePath.libraryRoot;
    final Directory libraryFolder = Directory(libraryRoot);
    File collectionFile = await CollectionData.jsonFile;
    File bookmarkFile = await BookmarkData.jsonFile;

    if (isBackupCollections) {
      collectionFile.copySync(join(libraryFolder.path, 'collection.json'));
    }

    if (isBackupBookmarks) {
      bookmarkFile.copySync(join(libraryFolder.path, 'bookmark.json'));
    }

    // Create a zip file
    final File zipFile = File(join(tempFolderPath, 'Library.zip'));
    zipFile.createSync();

    await ZipFile.createFromDirectory(sourceDir: libraryFolder, zipFile: zipFile);

    if (isBackupCollections) {
      File(join(libraryFolder.path, 'collection.json')).deleteSync();
    }

    if (isBackupBookmarks) {
      File(join(libraryFolder.path, 'bookmark.json')).deleteSync();
    }

    return zipFile;
  }

  static Future<void> restoreBackup(Directory tempFolder, File zipFile) async {
    final String libraryRoot = await FilePath.libraryRoot;
    final Directory libraryFolder = Directory(libraryRoot);
    libraryFolder.deleteSync(recursive: true);
    libraryFolder.createSync(recursive: true);
    await ZipFile.extractToDirectory(zipFile: zipFile, destinationDir: libraryFolder);
    final File collectionFile = File(join(libraryRoot, 'collection.json'));
    final File bookmarkFile = File(join(libraryRoot, 'bookmark.json'));

    if (collectionFile.existsSync()) {
      collectionFile.copySync(await CollectionData.jsonPath);
      collectionFile.deleteSync();
    }

    if (bookmarkFile.existsSync()) {
      bookmarkFile.copySync(await BookmarkData.jsonPath);
      bookmarkFile.deleteSync();
    }
  }

  BackupUtility._();
}
