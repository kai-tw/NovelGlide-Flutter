import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/file_path.dart';
import '../../../toolbox/backup_utility.dart';
import '../../../toolbox/random_utility.dart';

class BackupManagerLocalCubit extends Cubit<BackupManagerLocalState> {
  BackupManagerLocalCubit() : super(const BackupManagerLocalState());

  Future<void> createBackup() async {
    emit(const BackupManagerLocalState(code: BackupManagerLocalCode.loading));

    final Directory tempDirectory = RandomUtility.getAvailableTempFolder();
    tempDirectory.createSync(recursive: true);

    final File zipFile = await BackupUtility.createBackup(tempDirectory.path);
    zipFile.copySync(FilePath.instance.backupRoot);
    tempDirectory.deleteSync(recursive: true);

    if (!isClosed) {
      emit(const BackupManagerLocalState(code: BackupManagerLocalCode.success));
    }

    await Future.delayed(const Duration(seconds: 2));

    if (!isClosed) {
      emit(const BackupManagerLocalState(code: BackupManagerLocalCode.idle));
    }
  }
}

class BackupManagerLocalState extends Equatable {
  final BackupManagerLocalCode code;

  @override
  List<Object> get props => [code];

  const BackupManagerLocalState({this.code = BackupManagerLocalCode.idle});
}

enum BackupManagerLocalCode { idle, loading, success, error }
