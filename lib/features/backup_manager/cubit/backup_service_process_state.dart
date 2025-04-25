part of 'backup_service_process_cubit.dart';

class BackupServiceProcessState extends Equatable {
  const BackupServiceProcessState({
    this.library = const BackupServiceProcessItemState(),
    this.collection = const BackupServiceProcessItemState(),
    this.bookmark = const BackupServiceProcessItemState(),
  });

  final BackupServiceProcessItemState library;
  final BackupServiceProcessItemState collection;
  final BackupServiceProcessItemState bookmark;

  bool get isRunning =>
      library.isRunning || collection.isRunning || bookmark.isRunning;

  @override
  List<Object?> get props => <Object?>[
        library,
        collection,
        bookmark,
      ];

  BackupServiceProcessState copyWith({
    BackupServiceProcessItemState? library,
    BackupServiceProcessItemState? collection,
    BackupServiceProcessItemState? bookmark,
  }) {
    return BackupServiceProcessState(
      library: library ?? this.library,
      collection: collection ?? this.collection,
      bookmark: bookmark ?? this.bookmark,
    );
  }
}
