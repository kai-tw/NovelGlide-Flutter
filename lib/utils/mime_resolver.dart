import 'dart:io';

import 'package:mime/mime.dart';

class MimeResolver extends MimeTypeResolver {
  // Singleton instance of MimeResolver
  static final MimeResolver _instance = MimeResolver._internal();

  // Factory constructor to initialize the singleton instance
  factory MimeResolver._internal() {
    final instance = MimeResolver._();
    // Add magic numbers for specific file types
    instance.addMagicNumber([0x50, 0x4B, 0x03, 0x04], "application/epub+zip");
    instance.addMagicNumber([0x50, 0x4B, 0x03, 0x04], "application/zip");
    return instance;
  }

  // Private constructor
  MimeResolver._() : super();

  // Reads the header bytes of a file
  List<int> _getHeaderBytes(File file) {
    final openFile = file.openSync(mode: FileMode.read);
    // Initialize a list to store header bytes
    final headerBytes = List<int>.filled(magicNumbersMaxLength, 0);
    openFile.readIntoSync(headerBytes, 0, magicNumbersMaxLength);
    openFile.closeSync();
    return headerBytes;
  }

  // Looks up MIME type using header bytes
  static String? lookupByHeaderBytes(File file) {
    final headerBytes = _instance._getHeaderBytes(file);
    return _instance.lookup("", headerBytes: headerBytes);
  }

  // Looks up MIME type using file path and header bytes
  static String? lookupAll(File file) {
    final headerBytes = _instance._getHeaderBytes(file);
    return _instance.lookup(file.path, headerBytes: headerBytes);
  }
}
