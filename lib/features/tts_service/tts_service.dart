import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../core/services/preference_service/preference_service.dart';
import '../../generated/i18n/app_localizations.dart';

part 'data/tts_service_state.dart';
part 'data/tts_voice_data.dart';
part 'tts_settings_page/cubit/tts_settings_cubit.dart';
part 'tts_settings_page/cubit/tts_settings_state.dart';
part 'tts_settings_page/dialog/voice_select_dialog.dart';
part 'tts_settings_page/tts_settings_page.dart';
part 'tts_settings_page/widgets/demo_section.dart';
part 'tts_settings_page/widgets/slider.dart';
part 'tts_settings_page/widgets/voice_select_tile.dart';

class TtsService extends FlutterTts {
  factory TtsService({void Function()? onReady}) {
    final TtsService instance = TtsService._();

    instance.setProgressHandler();
    instance.reload().then((_) => onReady?.call());

    return instance;
  }

  TtsService._() : super();

  String? _pausedText;
  int? _pausedStartOffset;
  late TtsPreferenceData data;

  @override
  Future<dynamic> setPitch(double pitch) async {
    // Update data
    data = data.copyWith(pitch: pitch);

    // Save data
    await PreferenceService.tts.save(data);

    // reload
    await reload();
  }

  @override
  Future<dynamic> setVolume(double volume) async {
    // Update data
    data = data.copyWith(volume: volume);

    // Save data
    await PreferenceService.tts.save(data);

    // reload
    await reload();
  }

  @override
  Future<dynamic> setSpeechRate(double rate) async {
    // Update data
    data = data.copyWith(speechRate: rate);

    // Save data
    PreferenceService.tts.save(data);

    // reload
    await reload();
  }

  Future<void> setVoiceData(TtsVoiceData? value) async {
    // Update data
    data = data.copyWithVoiceData(value);

    // Save data
    PreferenceService.tts.save(data);

    // reload
    await reload();
  }

  Future<void> reload() async {
    data = await PreferenceService.tts.load();

    super.setPitch(data.pitch);
    super.setVolume(data.volume);
    super.setSpeechRate(data.speechRate);

    if (data.voiceData == null) {
      clearVoice();
    } else {
      await setVoice(data.voiceData!.toMap());
    }
  }

  @override
  void setProgressHandler([Function(String, int, int, String)? callback]) {
    super.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {
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

  Future<void> reset() async {
    await PreferenceService.tts.reset();

    // reload
    await reload();
  }

  Future<List<TtsVoiceData>> get voiceList async {
    final List<TtsVoiceData> voices = (await getVoices)
        .map<TtsVoiceData>((dynamic cur) => TtsVoiceData(
              name: cur['name'],
              locale: cur['locale'],
            ))
        .toList();

    voices
        .sort((TtsVoiceData a, TtsVoiceData b) => a.locale.compareTo(b.locale));

    return voices;
  }
}
