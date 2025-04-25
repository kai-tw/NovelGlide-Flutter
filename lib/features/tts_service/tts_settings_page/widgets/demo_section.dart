part of '../../tts_service.dart';

class _DemoSection extends StatelessWidget {
  const _DemoSection();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final TtsSettingsCubit cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
      child: Column(
        children: <Widget>[
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: (TtsSettingsState previous, TtsSettingsState current) =>
                previous.isTextEmpty != current.isTextEmpty,
            builder: (BuildContext context, TtsSettingsState state) {
              return TextField(
                controller: cubit.controller,
                decoration: InputDecoration(
                  labelText: appLocalizations.ttsSettingsTypeHere,
                  errorText: state.isTextEmpty
                      ? appLocalizations.ttsSettingsTypeSomeWords
                      : null,
                ),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
                buildWhen:
                    (TtsSettingsState previous, TtsSettingsState current) =>
                        previous.ttsState != current.ttsState ||
                        previous.isTextEmpty != current.isTextEmpty,
                builder: (BuildContext context, TtsSettingsState state) {
                  final bool isPlaying =
                      state.ttsState.isPlaying || state.ttsState.isContinued;
                  return TextButton.icon(
                    onPressed: isPlaying ? cubit.pause : cubit.play,
                    icon: Icon(
                        isPlaying ? Icons.pause_rounded : Icons.play_arrow),
                    label: Text(isPlaying
                        ? appLocalizations.ttsPause
                        : appLocalizations.ttsPlay),
                  );
                },
              ),
              BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
                buildWhen:
                    (TtsSettingsState previous, TtsSettingsState current) =>
                        previous.ttsState != current.ttsState,
                builder: (BuildContext context, TtsSettingsState state) {
                  return TextButton.icon(
                    onPressed: state.ttsState.isPlaying ||
                            state.ttsState.isContinued ||
                            state.ttsState.isPaused
                        ? cubit.stop
                        : null,
                    icon: const Icon(Icons.stop),
                    label: Text(appLocalizations.ttsStop),
                  );
                },
              ),
              BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
                buildWhen:
                    (TtsSettingsState previous, TtsSettingsState current) =>
                        previous.ttsState != current.ttsState,
                builder: (BuildContext context, TtsSettingsState state) {
                  return TextButton.icon(
                    onPressed: state.ttsState.isStopped ? cubit.reset : null,
                    icon: const Icon(Icons.replay),
                    label: Text(appLocalizations.ttsSettingsReset),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
