part of '../tts_settings.dart';

class _VoiceSelectTile extends StatelessWidget {
  const _VoiceSelectTile();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
      buildWhen: (previous, current) =>
          previous.ttsState != current.ttsState ||
          previous.voiceData != current.voiceData,
      builder: (context, state) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          leading: const Icon(Icons.record_voice_over_rounded),
          title: Text(appLocalizations.ttsSettingsSelectVoice),
          subtitle: Text(
            state.voiceData == null
                ? appLocalizations.generalDefault
                : "${state.voiceData!.getLocaleName(context)}\n${state.voiceData!.name}",
          ),
          onTap: state.ttsState.isStopped
              ? () async {
                  final voiceData = await showDialog<TtsVoiceData>(
                    context: context,
                    builder: (_) => _VoiceSelectDialog(
                      voiceList: cubit.state.voiceList,
                    ),
                  );
                  if (voiceData != null) {
                    cubit.setVoiceData(voiceData);
                  }
                }
              : null,
        );
      },
    );
  }
}
