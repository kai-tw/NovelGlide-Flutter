part of '../../backup_service.dart';

class CollectionBackupRepository extends BackupRepositoryOld {
  CollectionBackupRepository();

  @override
  Future<String> get fileName async =>
      (await FileSystemService.json.collectionJsonFile).baseName;
}
