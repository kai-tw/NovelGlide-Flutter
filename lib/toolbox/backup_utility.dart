import 'dart:convert';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

import 'file_path.dart';

class BackupUtility {
  static Future<File> createBackup(String tempFolderPath) async {
    // Read the backup settings
    final Box box = Hive.box(name: 'settings');
    final isBackupCollections = box.get('backupManager.isBackupCollections', defaultValue: false);
    final isBackupBookmarks = box.get('backupManager.isBackupBookmarks', defaultValue: false);
    box.close();

    final String libraryRoot = await FilePath.libraryRoot;
    final Directory libraryFolder = Directory(libraryRoot);
    File? collectionFile;
    File? bookmarkFile;

    if (isBackupCollections) {
      final Box collectionBox = Hive.box(name: 'collection');
      Map<String, dynamic> collectionJson = {};

      for (String key in collectionBox.keys) {
        collectionJson[key] = collectionBox.get(key);
      }

      collectionBox.close();

      collectionFile = File(join(libraryFolder.path, 'collection.json'));
      collectionFile.writeAsStringSync(jsonEncode(collectionJson));
    }

    if (isBackupBookmarks) {
      final Box bookmarkBox = Hive.box(name: 'bookmark');
      Map<String, dynamic> bookmarkJson = {};

      for (String key in bookmarkBox.keys) {
        bookmarkJson[key] = bookmarkBox.get(key);
      }

      bookmarkBox.close();

      bookmarkFile = File(join(libraryFolder.path, 'bookmark.json'));
      bookmarkFile.writeAsStringSync(jsonEncode(bookmarkJson));
    }

    // Create a zip file
    final File zipFile = File(join(tempFolderPath, 'Library_${DateTime.now().toIso8601String()}.zip'));
    zipFile.createSync();

    await ZipFile.createFromDirectory(sourceDir: libraryFolder, zipFile: zipFile);

    if (collectionFile != null) {
      collectionFile.deleteSync();
    }

    if (bookmarkFile != null) {
      bookmarkFile.deleteSync();
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
      final Map<String, dynamic> collectionJson = jsonDecode(collectionFile.readAsStringSync());
      final Box<Map<String, dynamic>> collectionBox = Hive.box(name: 'collection');
      collectionBox.clear();

      for (String key in collectionJson.keys) {
        collectionBox.put(key, collectionJson[key]);
      }

      collectionBox.close();
      collectionFile.deleteSync();
    }

    if (bookmarkFile.existsSync()) {
      final Map<String, dynamic> bookmarkJson = jsonDecode(bookmarkFile.readAsStringSync());
      final Box<Map<String, dynamic>> bookmarkBox = Hive.box(name: 'bookmark');
      bookmarkBox.clear();

      for (String key in bookmarkJson.keys) {
        bookmarkBox.put(key, bookmarkJson[key]);
      }

      bookmarkBox.close();
      bookmarkFile.deleteSync();
    }
  }

  BackupUtility._();
}
