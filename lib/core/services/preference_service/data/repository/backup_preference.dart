part of '../../preference_service.dart';

class BackupPreference extends PreferenceRepository<BackupPreferenceData> {
  final BackupPreferenceKey _key = BackupPreferenceKey();

  @override
  Future<BackupPreferenceData> load() async {
    return BackupPreferenceData(
      isGoogleDriveEnabled:
          await tryGetBool(_key.isGoogleDriveEnabled) ?? false,
    );
  }

  @override
  Future<void> reset() async {
    await Future.wait(<Future<void>>[
      remove(_key.isGoogleDriveEnabled),
    ]);
  }

  @override
  Future<void> save(BackupPreferenceData data) async {
    await Future.wait(<Future<void>>[
      setBool(_key.isGoogleDriveEnabled, data.isGoogleDriveEnabled),
    ]);
  }
}
