import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../domain/entities/tts_state_code.dart';
import '../cubit/tts_settings_cubit.dart';
import '../cubit/tts_settings_state.dart';

class TtsDemoSection extends StatelessWidget {
  const TtsDemoSection({super.key});

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
                  return TextButton.icon(
                    onPressed: switch (state.ttsState) {
                      TtsStateCode.ready => cubit.play,
                      TtsStateCode.initial => null,
                      TtsStateCode.playing => cubit.pause,
                      TtsStateCode.paused => cubit.resume,
                      TtsStateCode.continued => cubit.pause,
                      TtsStateCode.completed => cubit.play,
                      TtsStateCode.canceled => cubit.play,
                    },
                    icon: Icon(switch (state.ttsState) {
                      TtsStateCode.ready => Icons.play_arrow,
                      TtsStateCode.initial => Icons.play_arrow,
                      TtsStateCode.playing => Icons.pause,
                      TtsStateCode.paused => Icons.play_arrow,
                      TtsStateCode.continued => Icons.pause,
                      TtsStateCode.completed => Icons.play_arrow,
                      TtsStateCode.canceled => Icons.play_arrow,
                    }),
                    label: Text(switch (state.ttsState) {
                      TtsStateCode.ready => appLocalizations.ttsPlay,
                      TtsStateCode.initial => appLocalizations.ttsPlay,
                      TtsStateCode.playing => appLocalizations.ttsPause,
                      TtsStateCode.paused => appLocalizations.ttsPlay,
                      TtsStateCode.continued => appLocalizations.ttsPause,
                      TtsStateCode.completed => appLocalizations.ttsPlay,
                      TtsStateCode.canceled => appLocalizations.ttsPlay,
                    }),
                  );
                },
              ),
              BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
                buildWhen:
                    (TtsSettingsState previous, TtsSettingsState current) =>
                        previous.ttsState != current.ttsState,
                builder: (BuildContext context, TtsSettingsState state) {
                  return TextButton.icon(
                    onPressed: switch (state.ttsState) {
                      TtsStateCode.ready => null,
                      TtsStateCode.initial => null,
                      TtsStateCode.playing => cubit.stop,
                      TtsStateCode.paused => cubit.stop,
                      TtsStateCode.continued => cubit.stop,
                      TtsStateCode.completed => null,
                      TtsStateCode.canceled => null,
                    },
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
                    onPressed: switch (state.ttsState) {
                      TtsStateCode.ready => cubit.reset,
                      TtsStateCode.initial => null,
                      TtsStateCode.playing => null,
                      TtsStateCode.paused => null,
                      TtsStateCode.continued => null,
                      TtsStateCode.completed => cubit.reset,
                      TtsStateCode.canceled => cubit.reset,
                    },
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
