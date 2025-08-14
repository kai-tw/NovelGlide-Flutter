import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../domain/entities/tts_voice_data.dart';
import '../cubit/tts_settings_cubit.dart';
import '../cubit/tts_settings_state.dart';
import '../dialog/tts_voice_select_dialog.dart';

class TtsVoiceSelectTile extends StatelessWidget {
  const TtsVoiceSelectTile({super.key});

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
          onTap: state.ttsState.isReady
              ? () async {
                  final TtsVoiceData? voiceData =
                      await showDialog<TtsVoiceData>(
                    context: context,
                    builder: (_) => TtsVoiceSelectDialog(
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
