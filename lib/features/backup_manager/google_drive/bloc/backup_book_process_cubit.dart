part of '../backup_manager_google_drive.dart';

class _BackupBookProcessCubit extends Cubit<_ProcessDialogState> {
  factory _BackupBookProcessCubit() {
    final cubit =
        _BackupBookProcessCubit._internal(const _ProcessDialogState());
    WidgetsBinding.instance.addPostFrameCallback((_) => cubit._process());
    return cubit;
  }

  _BackupBookProcessCubit._internal(super.initialState);

  Future<void> _process() async {
    final tempFolder = RandomUtils.getAvailableTempFolder();
    tempFolder.createSync(recursive: true);
    await BackupUtils.archiveLibrary(
      tempFolder.path,
      onZipping: (progress) {
        emit(_ProcessDialogState(
          step: _ProcessStep.archive,
          progress: progress / 100,
        ));
      },
    );
    tempFolder.deleteSync(recursive: true);
  }
}
