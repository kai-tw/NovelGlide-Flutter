import 'package:mime/mime.dart';

class AdvancedMimeTypeResolver extends MimeTypeResolver {
  static final AdvancedMimeTypeResolver _instance = AdvancedMimeTypeResolver._internal();
  factory AdvancedMimeTypeResolver() {
    _instance.init();
    return _instance;
  }

  AdvancedMimeTypeResolver._internal() : super();

  void init() {
    _instance.addMagicNumber([0x50, 0x4B, 0x03, 0x04], "application/zip");
  }
}