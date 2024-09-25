import 'dart:io';

import 'package:mime/mime.dart';

class MimeResolver extends MimeTypeResolver {
  static final MimeResolver _instance = MimeResolver.__();

  factory MimeResolver.__() {
    MimeResolver instance = MimeResolver._();
    instance.addMagicNumber([0x50, 0x4B, 0x03, 0x04], "application/epub+zip");
    instance.addMagicNumber([0x50, 0x4B, 0x03, 0x04], "application/zip");
    return instance;
  }

  MimeResolver._() : super();

  List<int> _getHeaderBytes(File file) {
    final RandomAccessFile openFile = file.openSync(mode: FileMode.read);
    final List<int> headerBytes = List.generate(magicNumbersMaxLength, (_) => 0);
    openFile.readIntoSync(headerBytes, 0, magicNumbersMaxLength);
    openFile.closeSync();
    return headerBytes;
  }

  static String? lookupByHeaderBytes(File file) {
    final List<int> headerBytes = _instance._getHeaderBytes(file);
    return _instance.lookup("", headerBytes: headerBytes);
  }

  static String? lookupAll(File file) {
    final List<int> headerBytes = _instance._getHeaderBytes(file);
    return _instance.lookup(file.path, headerBytes: headerBytes);
  }
}