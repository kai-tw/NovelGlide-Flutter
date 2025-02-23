import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/tts_service_state.dart';
import '../bloc/tts_settings_cubit.dart';
import '../bloc/tts_settings_state.dart';

class TtsSettingsDemoSection extends StatelessWidget {
  const TtsSettingsDemoSection({super.key});

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
                    label: Text(appLocalizations.ttsSettingsPlay),
                  ),
                  TextButton.icon(
                    onPressed: state.ttsState == TtsServiceState.playing ||
                            state.ttsState == TtsServiceState.continued
                        ? cubit.pause
                        : null,
                    icon: const Icon(Icons.pause),
                    label: Text(appLocalizations.ttsSettingsPause),
                  ),
                  TextButton.icon(
                    onPressed: state.ttsState == TtsServiceState.playing ||
                            state.ttsState == TtsServiceState.continued ||
                            state.ttsState == TtsServiceState.paused
                        ? cubit.stop
                        : null,
                    icon: const Icon(Icons.stop),
                    label: Text(appLocalizations.ttsSettingsStop),
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
