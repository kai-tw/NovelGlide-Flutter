import 'dart:async';

import '../../domain/entities/backup_preference_data.dart';
import '../../domain/entities/preference_keys.dart';
import '../../domain/repositories/preference_repository.dart';
import '../data_sources/preference_local_data_source.dart';

class BackupPreferenceRepositoryImpl extends BackupPreferenceRepository {
  BackupPreferenceRepositoryImpl(
    this._preferenceRepository,
  );

  final PreferenceLocalDataSource _preferenceRepository;

  /// Stream controller
  final StreamController<BackupPreferenceData> _streamController =
      StreamController<BackupPreferenceData>.broadcast();

  @override
  Future<BackupPreferenceData> getPreference() async {
    return BackupPreferenceData(
      isGoogleDriveEnabled: await _preferenceRepository
              .tryGetBool(PreferenceKeys.backupIsGoogleDriveEnabled) ??
          false,
    );
  }

  @override
  Future<void> savePreference(BackupPreferenceData settings) async {
    await _preferenceRepository.setBool(
      PreferenceKeys.backupIsGoogleDriveEnabled,
      settings.isGoogleDriveEnabled,
    );

    _streamController.add(settings);
  }

  @override
  Stream<BackupPreferenceData> get onChangeStream => _streamController.stream;

  @override
  Future<void> resetPreference() async {
    await _preferenceRepository
        .remove(PreferenceKeys.backupIsGoogleDriveEnabled);
  }
}
