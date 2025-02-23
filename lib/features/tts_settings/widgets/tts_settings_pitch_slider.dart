import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/tts_service_state.dart';
import '../bloc/tts_settings_cubit.dart';
import '../bloc/tts_settings_state.dart';

class TtsSettingsPitchSlider extends StatelessWidget {
  const TtsSettingsPitchSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<TtsSettingsCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            appLocalizations.ttsSettingsPitch,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BlocBuilder<TtsSettingsCubit, TtsSettingsState>(
            buildWhen: (previous, current) =>
                previous.ttsState != current.ttsState ||
                previous.pitch != current.pitch,
            builder: (context, state) {
              return Slider(
                value: state.pitch,
                onChanged: state.ttsState == TtsServiceState.stopped
                    ? (value) => cubit.setPitch(value, false)
                    : null,
                onChangeEnd: (value) => cubit.setPitch(value, true),
                min: 0.5,
                max: 2.0,
                divisions: 15,
              );
            },
          ),
        ],
      ),
    );
  }
}
