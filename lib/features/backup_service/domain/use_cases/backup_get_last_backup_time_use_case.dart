import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/book_backup_repository.dart';
import '../repositories/bookmark_backup_repository.dart';
import '../repositories/collection_backup_repository.dart';

class BackupGetLastBackupTimeUseCase extends UseCase<Future<DateTime>, void> {
  const BackupGetLastBackupTimeUseCase(
    this._bookBackupRepository,
    this._bookmarkBackupRepository,
    this._collectionBackupRepository,
  );

  final BookBackupRepository _bookBackupRepository;
  final BookmarkBackupRepository _bookmarkBackupRepository;
  final CollectionBackupRepository _collectionBackupRepository;

  @override
  Future<DateTime> call([void parameter]) async {
    return (await Future.wait<DateTime?>(<Future<DateTime?>>[
      _bookBackupRepository.lastBackupTime,
      _bookmarkBackupRepository.lastBackupTime,
      _collectionBackupRepository.lastBackupTime,
    ]))
        .whereType<DateTime>()
        .reduce((DateTime a, DateTime b) => a.isAfter(b) ? a : b);
  }
}
