import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'bloc/tts_settings_cubit.dart';
import 'widgets/tts_settings_demo_section.dart';
import 'widgets/tts_settings_pitch_slider.dart';
import 'widgets/tts_settings_speech_rate_slider.dart';
import 'widgets/tts_settings_volume_slider.dart';

class TtsSettings extends StatelessWidget {
  const TtsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TtsSettingsCubit(),
      child: const _PageScaffold(),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  const _PageScaffold();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.ttsSettingsTitle),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TtsSettingsDemoSection(),
            TtsSettingsPitchSlider(),
            TtsSettingsVolumeSlider(),
            TtsSettingsSpeechRateSlider(),
          ],
        ),
      ),
    );
  }
}
