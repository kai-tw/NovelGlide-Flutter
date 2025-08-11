import 'dart:typed_data';

import 'package:mime/mime.dart';

import '../../../../file_system/domain/repositories/file_system_repository.dart';
import '../mime_local_source.dart';

class MimeLocalSourceImpl implements MimeLocalSource {
  factory MimeLocalSourceImpl(
    FileSystemRepository fileSystemRepository,
  ) {
    final MimeTypeResolver resolver = MimeTypeResolver();

    // Setup magic numbers
    resolver
        .addMagicNumber(<int>[0x50, 0x4B, 0x03, 0x04], 'application/epub+zip');
    resolver.addMagicNumber(<int>[0x50, 0x4B, 0x03, 0x04], 'application/zip');

    return MimeLocalSourceImpl._(
      resolver,
      fileSystemRepository,
    );
  }

  MimeLocalSourceImpl._(
    this._resolver,
    this._fileSystemRepository,
  );

  final MimeTypeResolver _resolver;
  final FileSystemRepository _fileSystemRepository;

  @override
  Future<String?> lookupAll(String path) async {
    final List<int> headerBytes = await _getHeaderBytes(path);
    return _resolver.lookup(path, headerBytes: headerBytes);
  }

  // Reads the header bytes of a file
  Future<Uint8List> _getHeaderBytes(String path) async {
    return _fileSystemRepository.readFileAsBytes(
      path,
      start: 0,
      end: _resolver.magicNumbersMaxLength,
    );
  }
}
