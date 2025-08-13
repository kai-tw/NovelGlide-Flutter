import 'dart:typed_data';

import '../entities/cloud_file.dart';
import '../entities/cloud_providers.dart';

abstract class CloudRepository {
  Future<CloudFile> getFile(CloudProviders providers, String fileName);

  Future<void> uploadFile(
    CloudProviders providers,
    String path, {
    void Function(double progress)? onUpload,
  });

  Future<void> deleteFile(CloudProviders providers, String fileId);

  Stream<Uint8List> downloadFile(
    CloudProviders providers,
    String fileId, {
    void Function(double progress)? onDownload,
  });
}
