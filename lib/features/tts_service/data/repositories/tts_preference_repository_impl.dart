import 'dart:async';
import 'dart:convert';

import 'package:novel_glide/features/tts_service/domain/entities/tts_preference_data.dart';

import '../../../preference/domain/entities/preference_keys.dart';
import '../../../preference/domain/repositories/preference_repository.dart';
import '../../domain/entities/tts_voice_data.dart';
import '../../domain/repositories/tts_preference_repository.dart';

class TtsPreferenceRepositoryImpl implements TtsPreferenceRepository {
  TtsPreferenceRepositoryImpl(this._preferenceRepository);

  final PreferenceRepository _preferenceRepository;
  final StreamController<void> _onChangedController =
      StreamController<void>.broadcast();

  @override
  Stream<void> get onChangedStream => _onChangedController.stream;

  @override
  Future<TtsPreferenceData> getPreference() async {
    // Get the data from preference
    final double? pitchPref =
        await _preferenceRepository.tryGetDouble(PreferenceKeys.ttsPitch);
    final double? volumePref =
        await _preferenceRepository.tryGetDouble(PreferenceKeys.ttsVolume);
    final double? speechRatePref =
        await _preferenceRepository.tryGetDouble(PreferenceKeys.ttsSpeechRate);
    final String? voiceDataPref =
        await _preferenceRepository.tryGetString(PreferenceKeys.ttsVoiceData);

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
  Future<void> reset() async {
    await Future.wait(<Future<void>>[
      _preferenceRepository.remove(PreferenceKeys.ttsPitch),
      _preferenceRepository.remove(PreferenceKeys.ttsVolume),
      _preferenceRepository.remove(PreferenceKeys.ttsSpeechRate),
      _preferenceRepository.remove(PreferenceKeys.ttsVoiceData),
    ]);

    // Notify listeners.
    _onChangedController.add(null);
  }

  @override
  Future<void> save(TtsPreferenceData data) async {
    // Encode the voice data to json
    String? voiceDataJson;

    if (data.voiceData != null) {
      voiceDataJson = jsonEncode(<String, dynamic>{
        'name': data.voiceData!.name,
        'locale': data.voiceData!.locale,
      });
    }

    await Future.wait(<Future<void>>[
      _preferenceRepository.setDouble(PreferenceKeys.ttsPitch, data.pitch),
      _preferenceRepository.setDouble(PreferenceKeys.ttsVolume, data.volume),
      _preferenceRepository.setDouble(
          PreferenceKeys.ttsSpeechRate, data.speechRate),
      voiceDataJson == null
          ? _preferenceRepository.remove(PreferenceKeys.ttsVoiceData)
          : _preferenceRepository.setString(
              PreferenceKeys.ttsVoiceData, voiceDataJson),
    ]);

    // Notify listeners.
    _onChangedController.add(null);
  }
}
