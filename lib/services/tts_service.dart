import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../preference_keys/preference_keys.dart';

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

  double get pitch => _pitch ?? defaultPitch;
  double get volume => _volume ?? defaultVolume;
  double get speechRate => _speechRate ?? defaultSpeedRate;

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

  factory TtsService({void Function()? onReady}) {
    final instance = TtsService._();
    instance.setProgressHandler();
    return instance.._init(onReady);
  }

  TtsService._() : super();

  Future<void> _init(void Function()? onReady) async {
    prefs = await SharedPreferences.getInstance();
    _pitch = prefs.getDouble(PreferenceKeys.tts.pitch);
    _volume = prefs.getDouble(PreferenceKeys.tts.volume);
    _speechRate = prefs.getDouble(PreferenceKeys.tts.speedRate);
    await setPitch(pitch);
    await setVolume(volume);
    await setSpeechRate(speechRate);
    onReady?.call();
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

  void reset() async {
    pitch = defaultPitch;
    volume = defaultVolume;
    speechRate = defaultSpeedRate;
  }

  Future<List<String>> getDataList() async {
    List<String> languageList =
        (await getLanguages).map<String>((e) => e.toString()).toList();
    languageList.sort();

    return languageList;
  }
}
