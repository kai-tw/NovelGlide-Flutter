part of '../../tts_service.dart';

class _VoiceSelectTile extends StatelessWidget {
  const _VoiceSelectTile();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final TtsSettingsCubit cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
      buildWhen: (TtsSettingsState previous, TtsSettingsState current) =>
          previous.ttsState != current.ttsState ||
          previous.data != current.data,
      builder: (BuildContext context, TtsSettingsState state) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          leading: const Icon(Icons.record_voice_over_rounded),
          title: Text(appLocalizations.ttsSettingsSelectVoice),
          subtitle: Text(
            state.data.voiceData == null
                ? appLocalizations.generalDefault
                : '${state.data.voiceData!.getLocaleName(context)}\n${state.data.voiceData!.name}',
          ),
          onTap: state.ttsState.isStopped
              ? () async {
                  final TtsVoiceData? voiceData =
                      await showDialog<TtsVoiceData>(
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
