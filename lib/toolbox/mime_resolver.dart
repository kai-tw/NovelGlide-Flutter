import 'dart:io';

import 'package:mime/mime.dart';

class MimeResolver extends MimeTypeResolver {
  static MimeResolver get instance => _instance;
  static final MimeResolver _instance = MimeResolver._internal();

  bool _isInit = false;

  factory MimeResolver() {
    _instance.init();
    return _instance;
  }

  MimeResolver._internal() : super();

  void init() {
    if (_isInit) return;

    addMagicNumber([0x50, 0x4B, 0x03, 0x04], "application/zip");

    _isInit = true;
  }

  String? lookupByHeaderBytes(File file) {
    final List<int> headerBytes = _getHeaderBytes(file);
    return lookup("", headerBytes: headerBytes);
  }

  String? lookupAll(File file) {
    final List<int> headerBytes = _getHeaderBytes(file);
    return lookup(file.path, headerBytes: headerBytes);
  }

  List<int> _getHeaderBytes(File file) {
    final RandomAccessFile openFile = file.openSync(mode: FileMode.read);
    final List<int> headerBytes = List.generate(magicNumbersMaxLength, (_) => 0);
    openFile.readIntoSync(headerBytes, 0, magicNumbersMaxLength);
    openFile.closeSync();
    return headerBytes;
  }
}