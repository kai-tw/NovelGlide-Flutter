import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:novel_glide/features/tts_service/domain/entities/tts_voice_data.dart';

import '../../../../core/log_system/log_system.dart';
import '../../../preference/domain/entities/tts_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';
import '../../domain/entities/tts_state_code.dart';
import '../../domain/repositories/tts_engine.dart';

class TtsEngineImpl implements TtsEngine {
  factory TtsEngineImpl(
    TtsPreferenceRepository preferenceRepository,
  ) {
    final FlutterTts tts = FlutterTts();
    final TtsEngineImpl instance = TtsEngineImpl._(
      tts,
      preferenceRepository,
    );

    // Setup the progress handler to process the pausing function in Android.
    tts.setProgressHandler((
      String text,
      int startOffset,
      int endOffset,
      String word,
    ) {
      instance._pausedText = text;
      instance._pausedStartOffset = startOffset;
    });

    // Setup handlers
    tts.setStartHandler(instance._startHandler);
    tts.setCompletionHandler(instance._completionHandler);
    tts.setPauseHandler(instance._pauseHandler);
    tts.setCancelHandler(instance._cancelHandler);
    tts.setContinueHandler(instance._continueHandler);
    tts.setErrorHandler(instance._errorHandler);

    return instance;
  }

  TtsEngineImpl._(
    this._tts,
    this._preferenceRepository,
  );

  final TtsPreferenceRepository _preferenceRepository;

  final FlutterTts _tts;
  final StreamController<TtsStateCode> _streamController =
      StreamController<TtsStateCode>.broadcast();

  String? _pausedText;
  int? _pausedStartOffset;

  /// Handlers
  void _startHandler() {
    _streamController.add(TtsStateCode.playing);
  }

  void _completionHandler() {
    _pausedText = null;
    _pausedStartOffset = null;
    _streamController.add(TtsStateCode.completed);
  }

  void _pauseHandler() {
    _streamController.add(TtsStateCode.paused);
  }

  void _cancelHandler() {
    _streamController.add(TtsStateCode.canceled);
  }

  void _continueHandler() {
    _streamController.add(TtsStateCode.continued);
  }

  void _errorHandler(dynamic e) {
    LogSystem.error('An error occurred in TTS.', error: e);
    _streamController.add(TtsStateCode.canceled);
  }

  @override
  Stream<TtsStateCode> get stateChangedStream => _streamController.stream;

  @override
  Future<List<TtsVoiceData>> get voiceList async {
    final List<TtsVoiceData> voices = (await _tts.getVoices)
        .map<TtsVoiceData>((dynamic cur) =>
            TtsVoiceData(name: cur['name'], locale: cur['locale']))
        .toList();

    voices
        .sort((TtsVoiceData a, TtsVoiceData b) => a.locale.compareTo(b.locale));

    return voices;
  }

  @override
  Future<void> pause() async {
    await _tts.pause();
  }

  @override
  Future<void> reloadPreference() async {
    // Load preferences
    final TtsPreferenceData pref = await _preferenceRepository.getPreference();

    // Apply
    _tts.setPitch(pref.pitch);
    _tts.setVolume(pref.volume);
    _tts.setSpeechRate(pref.speechRate);

    if (pref.voiceData == null) {
      await _tts.clearVoice();
    } else {
      await _tts.setVoice(<String, String>{
        'name': pref.voiceData!.name,
        'locale': pref.voiceData!.locale,
      });
    }

    _streamController.add(TtsStateCode.ready);
  }

  @override
  Future<void> reset() async {
    await _preferenceRepository.resetPreference();
    await reloadPreference();
  }

  @override
  Future<void> resume() async {
    if (_pausedText != null && _pausedStartOffset != null) {
      await _tts.speak(_pausedText!.substring(_pausedStartOffset!));
    }
  }

  @override
  Future<void> setPitch(double pitch) async {
    // Change the pitch of TTS
    await _tts.setPitch(pitch);

    // Update preferences
    final TtsPreferenceData pref = await _preferenceRepository.getPreference();
    await _preferenceRepository.savePreference(pref.copyWith(pitch: pitch));
  }

  @override
  Future<void> setSpeechRate(double speechRate) async {
    // Change the pitch of TTS
    await _tts.setSpeechRate(speechRate);

    // Update preferences
    final TtsPreferenceData pref = await _preferenceRepository.getPreference();
    await _preferenceRepository
        .savePreference(pref.copyWith(speechRate: speechRate));
  }

  @override
  Future<void> setVoiceData(TtsVoiceData? voiceData) async {
    // Change the pitch of TTS
    if (voiceData == null) {
      await _tts.clearVoice();
    } else {
      await _tts.setVoice(<String, String>{
        'name': voiceData.name,
        'locale': voiceData.locale,
      });
    }

    // Update preferences
    final TtsPreferenceData pref = await _preferenceRepository.getPreference();
    await _preferenceRepository
        .savePreference(pref.copyWithVoiceData(voiceData));
  }

  @override
  Future<void> setVolume(double volume) async {
    // Change the pitch of TTS
    await _tts.setVolume(volume);

    // Update preferences
    final TtsPreferenceData pref = await _preferenceRepository.getPreference();
    await _preferenceRepository.savePreference(pref.copyWith(volume: volume));
  }

  @override
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
    _tts.cancelHandler?.call();
  }
}
