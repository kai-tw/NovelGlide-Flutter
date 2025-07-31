part of '../../preference_service.dart';

class TtsPreference extends PreferenceRepository<TtsPreferenceData> {
  TtsPreference();

  final TtsPreferenceKey _key = TtsPreferenceKey();

  @override
  Future<TtsPreferenceData> load() async {
    final String? voiceDataJsonString = await tryGetString(_key.voiceData);
    return TtsPreferenceData(
      pitch: await tryGetDouble(_key.pitch) ?? TtsPreferenceData.defaultPitch,
      volume:
          await tryGetDouble(_key.volume) ?? TtsPreferenceData.defaultVolume,
      speechRate: await tryGetDouble(_key.speedRate) ??
          TtsPreferenceData.defaultSpeedRate,
      voiceData: voiceDataJsonString == null
          ? null
          : TtsVoiceData.fromJson(voiceDataJsonString),
    );
  }

  @override
  Future<void> reset() async {
    await Future.wait(<Future<void>>[
      setDouble(_key.pitch, TtsPreferenceData.defaultPitch),
      setDouble(_key.volume, TtsPreferenceData.defaultVolume),
      setDouble(_key.speedRate, TtsPreferenceData.defaultSpeedRate),
      remove(_key.voiceData),
    ]);

    // Notify listeners.
    onChangedController.add(null);
  }

  @override
  Future<void> save(TtsPreferenceData data) async {
    await Future.wait(<Future<void>>[
      setDouble(_key.pitch, data.pitch),
      setDouble(_key.volume, data.volume),
      setDouble(_key.speedRate, data.speechRate),
      data.voiceData == null
          ? remove(_key.voiceData)
          : setString(_key.voiceData, data.voiceData!.toJson()),
    ]);

    // Notify listeners.
    onChangedController.add(null);
  }
}
