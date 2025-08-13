import 'dart:async';
import 'dart:typed_data';

import 'package:googleapis/drive/v3.dart';
import 'package:path/path.dart';

import '../../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../../core/log_system/log_system.dart';
import '../../../../../core/mime_resolver/domain/repositories/mime_repository.dart';
import '../../../../auth/domain/entities/auth_providers.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';
import '../../../domain/entities/cloud_file.dart';
import '../cloud_drive_api.dart';

class GoogleDriveApi implements CloudDriveApi {
  GoogleDriveApi(
    this._authRepository,
    this._fileSystemRepository,
    this._mimeRepository,
  );

  final AuthRepository _authRepository;
  final FileSystemRepository _fileSystemRepository;
  final MimeRepository _mimeRepository;

  final String _appDataFolder = 'appDataFolder';

  Future<DriveApi> get _driveApi async {
    return DriveApi(await _authRepository.getClient(
      AuthProviders.google,
      <String>[
        DriveApi.driveAppdataScope,
        DriveApi.driveFileScope,
      ],
    ));
  }

  Future<FilesResource> get _files async => (await _driveApi).files;

  @override
  Future<void> deleteFile(String fileId) async {
    return (await _files).delete(fileId);
  }

  @override
  Stream<Uint8List> downloadFile(
    String fileId, {
    void Function(double progress)? onDownload,
  }) {
    // Create stream controller
    final StreamController<Uint8List> streamController =
        StreamController<Uint8List>();

    // Start runner
    _downloadFileRunner(fileId, onDownload, streamController);

    // Return the stream
    return streamController.stream;
  }

  Future<void> _downloadFileRunner(
    String fileId,
    void Function(double progress)? onDownload,
    StreamController<Uint8List> streamController,
  ) async {
    final CloudFile? file = await getFile(fileId);

    if (file == null) {
      LogSystem.error('Try to download the file that does not exist.');
      return;
    }

    final int fileSize = file.length;

    // Get the media of file
    final Media media = await (await _files).get(
      fileId,
      downloadOptions: DownloadOptions.fullMedia,
    ) as Media;
    int transferredByteCount = 0;

    // Start downloading
    media.stream.listen(
      (List<int> data) {
        streamController.add(Uint8List.fromList(data));
        transferredByteCount += data.length;
        onDownload?.call((transferredByteCount / fileSize).clamp(0, 1));
      },
      onDone: () {
        // Transfer completed. Close the stream.
        streamController.close();
        onDownload?.call(1);
      },
      onError: (Object e) {
        LogSystem.error(
          'An error occurred while download a file from Google Drive',
          error: e,
        );
        streamController.close();
      },
    );
  }

  @override
  Future<CloudFile?> getFile(String fileName) async {
    // Get the file id by name first.
    final String? fileId = await _getFileId(fileName);

    if (fileId == null) {
      // File does not exist.
      return null;
    } else {
      // File exists. Get the metadata of this file.
      final File metadata = await (await _files).get(
        fileId,
        $fields: 'files(name,createdTime,id,mimeType,modifiedTime)',
      ) as File;
      return CloudFile(
        identifier: metadata.id ?? fileId,
        name: metadata.name ?? '',
        length: int.tryParse(metadata.size ?? '0') ?? 0,
        modifiedTime: metadata.modifiedTime!,
      );
    }
  }

  @override
  Future<void> uploadFile(
    String path, {
    void Function(double progress)? onUpload,
  }) async {
    // Get the file id by name to check if the file exists.
    final String? fileId = await _getFileId(basename(path));

    // Create the stream of the file
    int byteCount = 0;
    final int fileLength = await _fileSystemRepository.getFileSize(path);
    final Stream<List<int>> stream = _fileSystemRepository
        .streamFileAsBytes(path)
        .transform(StreamTransformer<Uint8List, List<int>>.fromHandlers(
          handleData: (List<int> data, EventSink<List<int>> sink) {
            byteCount += data.length;
            onUpload?.call((byteCount / fileLength).clamp(0, 1));
            sink.add(data);
          },
          handleError: (Object e, StackTrace s, EventSink<List<int>> sink) {
            LogSystem.error(
              'An error occurred while uploading a file to Google Drive.',
              error: e,
              stackTrace: s,
            );
            sink.close();
          },
          handleDone: (EventSink<List<int>> sink) {
            sink.close();
          },
        ));

    // Create the metadata of the file.
    final File metadata = File();
    metadata.name = basename(path);
    metadata.parents = <String>[_appDataFolder];
    metadata.mimeType = await _mimeRepository.lookupAll(path);

    final Media media = Media(stream, fileLength);

    if (fileId == null) {
      // File does not exist. Create it.
      await (await _files).create(metadata, uploadMedia: media);
    } else {
      // File exists. Update it.
      await (await _files).update(metadata, fileId, uploadMedia: media);
    }
  }

  Future<String?> _getFileId(String fileName) async {
    // Search the file by name in the app data folder.
    final FileList fileList = await (await _files).list(
      spaces: _appDataFolder,
      q: "name = '$fileName'",
      pageSize: 1,
    );

    return fileList.files?.isNotEmpty == true ? fileList.files?.first.id : null;
  }
}
