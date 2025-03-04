import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/i18n/app_localizations.dart';
import '../../preference_keys/preference_keys.dart';

part 'tts_service_state.dart';
part 'tts_voice_data.dart';

class TtsService extends FlutterTts {
  static const double defaultPitch = 1.0;
  static const double defaultVolume = 1.0;
  static const double defaultSpeedRate = 0.5;

  late final SharedPreferences prefs;
  String? _pausedText;
  int? _pausedStartOffset;
  double? _pitch;
  double? _volume;
  double? _speechRate;
  TtsVoiceData? _voiceData;

  double get pitch => _pitch ?? defaultPitch;
  double get volume => _volume ?? defaultVolume;
  double get speechRate => _speechRate ?? defaultSpeedRate;
  TtsVoiceData? get voiceData => _voiceData;

  set pitch(double value) {
    _pitch = value;
    prefs.setDouble(PreferenceKeys.tts.pitch, value);
    setPitch(value);
  }

  set volume(double value) {
    _volume = value;
    prefs.setDouble(PreferenceKeys.tts.volume, value);
    setVolume(value);
  }

  set speechRate(double value) {
    _speechRate = value;
    prefs.setDouble(PreferenceKeys.tts.speedRate, value);
    setSpeechRate(value);
  }

  set voiceData(TtsVoiceData? value) {
    _voiceData = value;
    if (value == null) {
      prefs.remove(PreferenceKeys.tts.voiceData);
      clearVoice();
    } else {
      prefs.setString(PreferenceKeys.tts.voiceData, value.toJson());
      setVoice(value.toMap());
    }
  }

  factory TtsService({void Function()? onReady}) {
    final instance = TtsService._();
    instance.setProgressHandler();
    return instance.._init(onReady);
  }

  TtsService._() : super();

  Future<void> _init(void Function()? onReady) async {
    prefs = await SharedPreferences.getInstance();
    await reload();
    onReady?.call();
  }

  Future<void> reload() async {
    _pitch = prefs.getDouble(PreferenceKeys.tts.pitch);
    _volume = prefs.getDouble(PreferenceKeys.tts.volume);
    _speechRate = prefs.getDouble(PreferenceKeys.tts.speedRate);

    await setPitch(pitch);
    await setVolume(volume);
    await setSpeechRate(speechRate);

    final voiceData = prefs.getString(PreferenceKeys.tts.voiceData);
    _voiceData = voiceData == null ? null : TtsVoiceData.fromJson(voiceData);
    if (_voiceData == null) {
      clearVoice();
    } else {
      await setVoice(_voiceData!.toMap());
    }
  }

  @override
  void setProgressHandler([Function(String, int, int, String)? callback]) {
    super.setProgressHandler((text, startOffset, endOffset, word) {
      _pausedText = text;
      _pausedStartOffset = startOffset;
      callback?.call(text, startOffset, endOffset, word);
    });
  }

  Future<void> resume() async {
    if (_pausedText != null && _pausedStartOffset != null) {
      await speak(_pausedText!.substring(_pausedStartOffset!));
    }
  }

  @override
  Future<void> stop() async {
    _pausedText = null;
    _pausedStartOffset = null;
    cancelHandler?.call();
    await super.stop();
  }

  void reset() {
    pitch = defaultPitch;
    volume = defaultVolume;
    speechRate = defaultSpeedRate;
    voiceData = null;
  }

  Future<List<TtsVoiceData>> get voiceList async {
    List<TtsVoiceData> voices = (await getVoices).map<TtsVoiceData>((cur) {
      return TtsVoiceData(
        name: cur['name'],
        locale: cur['locale'],
      );
    }).toList();

    voices.sort((a, b) => a.locale.compareTo(b.locale));

    return voices;
  }
}
