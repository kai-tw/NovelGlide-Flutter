import 'dart:async';
import 'dart:convert';

import 'package:novel_glide/features/preference/domain/entities/tts_preference_data.dart';

import '../../../tts_service/domain/entities/tts_voice_data.dart';
import '../../domain/entities/preference_keys.dart';
import '../../domain/repositories/preference_repository.dart';
import '../data_sources/preference_local_data_source.dart';

class TtsPreferenceRepositoryImpl implements TtsPreferenceRepository {
  TtsPreferenceRepositoryImpl(this._localDataSource);

  final PreferenceLocalDataSource _localDataSource;

  @override
  Stream<TtsPreferenceData> get onChangedStream => throw NoSuchMethodError;

  @override
  Future<TtsPreferenceData> getPreference() async {
    // Get the data from preference
    final double? pitchPref =
        await _localDataSource.tryGetDouble(PreferenceKeys.ttsPitch);
    final double? volumePref =
        await _localDataSource.tryGetDouble(PreferenceKeys.ttsVolume);
    final double? speechRatePref =
        await _localDataSource.tryGetDouble(PreferenceKeys.ttsSpeechRate);
    final String? voiceDataPref =
        await _localDataSource.tryGetString(PreferenceKeys.ttsVoiceData);

    // Parse voice data json
    TtsVoiceData? voiceData;
    if (voiceDataPref != null) {
      final Map<String, dynamic> voiceDataJson = jsonDecode(voiceDataPref);
      voiceData = TtsVoiceData(
        name: voiceDataJson['name'],
        locale: voiceDataJson['locale'],
      );
    }

    return TtsPreferenceData(
      pitch: pitchPref ?? TtsPreferenceData.defaultPitch,
      volume: volumePref ?? TtsPreferenceData.defaultVolume,
      speechRate: speechRatePref ?? TtsPreferenceData.defaultSpeedRate,
      voiceData: voiceData,
    );
  }

  @override
  Future<void> resetPreference() async {
    await Future.wait(<Future<void>>[
      _localDataSource.remove(PreferenceKeys.ttsPitch),
      _localDataSource.remove(PreferenceKeys.ttsVolume),
      _localDataSource.remove(PreferenceKeys.ttsSpeechRate),
      _localDataSource.remove(PreferenceKeys.ttsVoiceData),
    ]);
  }

  @override
  Future<void> savePreference(TtsPreferenceData data) async {
    // Encode the voice data to json
    String? voiceDataJson;

    if (data.voiceData != null) {
      voiceDataJson = jsonEncode(<String, dynamic>{
        'name': data.voiceData!.name,
        'locale': data.voiceData!.locale,
      });
    }

    await Future.wait(<Future<void>>[
      _localDataSource.setDouble(PreferenceKeys.ttsPitch, data.pitch),
      _localDataSource.setDouble(PreferenceKeys.ttsVolume, data.volume),
      _localDataSource.setDouble(PreferenceKeys.ttsSpeechRate, data.speechRate),
      voiceDataJson == null
          ? _localDataSource.remove(PreferenceKeys.ttsVoiceData)
          : _localDataSource.setString(
              PreferenceKeys.ttsVoiceData, voiceDataJson),
    ]);
  }
}
