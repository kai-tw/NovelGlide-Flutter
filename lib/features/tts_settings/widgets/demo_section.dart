part of '../tts_settings.dart';

class _DemoSection extends StatelessWidget {
  const _DemoSection();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
      child: Column(
        children: [
          TextField(
            controller: cubit.controller,
            decoration: InputDecoration(
              labelText: appLocalizations.ttsSettingsTypeHere,
            ),
          ),
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: (previous, current) =>
                previous.ttsState != current.ttsState,
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: state.ttsState == TtsServiceState.stopped ||
                            state.ttsState == TtsServiceState.paused
                        ? cubit.play
                        : null,
                    icon: const Icon(Icons.play_arrow),
                    label: Text(appLocalizations.ttsPlay),
                  ),
                  TextButton.icon(
                    onPressed: state.ttsState == TtsServiceState.playing ||
                            state.ttsState == TtsServiceState.continued
                        ? cubit.pause
                        : null,
                    icon: const Icon(Icons.pause),
                    label: Text(appLocalizations.ttsPause),
                  ),
                  TextButton.icon(
                    onPressed: state.ttsState == TtsServiceState.playing ||
                            state.ttsState == TtsServiceState.continued ||
                            state.ttsState == TtsServiceState.paused
                        ? cubit.stop
                        : null,
                    icon: const Icon(Icons.stop),
                    label: Text(appLocalizations.ttsStop),
                  ),
                  TextButton.icon(
                    onPressed: state.ttsState == TtsServiceState.stopped
                        ? cubit.reset
                        : null,
                    icon: const Icon(Icons.replay),
                    label: Text(appLocalizations.ttsSettingsReset),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
