import 'dart:io';

import 'package:mime/mime.dart';

class AdvancedMimeTypeResolver extends MimeTypeResolver {
  static final AdvancedMimeTypeResolver _instance = AdvancedMimeTypeResolver._internal();

  bool _isInit = false;

  factory AdvancedMimeTypeResolver() {
    _instance.init();
    return _instance;
  }

  AdvancedMimeTypeResolver._internal() : super();

  void init() {
    if (_isInit) return;

    _instance.addMagicNumber([0x50, 0x4B, 0x03, 0x04], "application/zip");

    _isInit = true;
  }

  String? lookupByMagicNumber(File file) {
    final RandomAccessFile openFile = file.openSync(mode: FileMode.read);
    final List<int> headerBytes = List.generate(magicNumbersMaxLength, (_) => 0);

    openFile.readIntoSync(headerBytes, 0, magicNumbersMaxLength);
    final String? mimeType = AdvancedMimeTypeResolver().lookup("", headerBytes: headerBytes);
    openFile.closeSync();

    return mimeType;
  }
}