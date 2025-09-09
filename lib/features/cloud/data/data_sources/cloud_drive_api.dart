import 'dart:typed_data';

import '../../domain/entities/cloud_file.dart';

abstract class CloudDriveApi {
  Future<CloudFile?> getFile(String fileName);

  Future<void> uploadFile(
    String path, {
    void Function(double progress)? onUpload,
  });

  Future<void> deleteFile(String fileId);

  Stream<Uint8List> downloadFile(
    CloudFile cloudFile, {
    void Function(double progress)? onDownload,
  });
}
