part of '../../preference_service.dart';

class BackupPreferenceData extends Equatable {
  const BackupPreferenceData({
    required this.isGoogleDriveEnabled,
  });

  final bool isGoogleDriveEnabled;

  @override
  List<Object?> get props => <Object?>[
        isGoogleDriveEnabled,
      ];
}
