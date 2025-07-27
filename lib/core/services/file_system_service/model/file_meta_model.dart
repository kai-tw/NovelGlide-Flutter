part of '../file_system_service.dart';

abstract class FileMetaModel extends Equatable {
  const FileMetaModel(this.file);

  final File file;

  String get path => file.path;

  String get baseName => basename(path);

  @override
  List<Object?> get props => <Object?>[file];
}
