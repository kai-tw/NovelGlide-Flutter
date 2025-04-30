part of '../tts_service.dart';

class TtsSettingsPage extends StatelessWidget {
  const TtsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TtsSettingsCubit>(
      create: (_) => TtsSettingsCubit(),
      child: const _PageScaffold(),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  const _PageScaffold();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final TtsSettingsCubit cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.ttsSettingsTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const _DemoSection(),
            const _VoiceSelectTile(),
            _Slider(
              title: appLocalizations.ttsSettingsPitch,
              buildWhen:
                  (TtsSettingsState previous, TtsSettingsState current) =>
                      previous.ttsState != current.ttsState ||
                      previous.pitch != current.pitch,
              onChanged: cubit.setPitch,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              valueSelector: (TtsSettingsState state) => state.pitch,
            ),
            _Slider(
              title: appLocalizations.ttsSettingsVolume,
              buildWhen:
                  (TtsSettingsState previous, TtsSettingsState current) =>
                      previous.ttsState != current.ttsState ||
                      previous.volume != current.volume,
              onChanged: cubit.setVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              valueSelector: (TtsSettingsState state) => state.volume,
            ),
            _Slider(
              title: appLocalizations.ttsSettingsSpeechRate,
              buildWhen:
                  (TtsSettingsState previous, TtsSettingsState current) =>
                      previous.ttsState != current.ttsState ||
                      previous.speechRate != current.speechRate,
              onChanged: cubit.setSpeechRate,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              valueSelector: (TtsSettingsState state) => state.speechRate,
            ),
          ],
        ),
      ),
    );
  }
}
