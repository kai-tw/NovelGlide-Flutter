import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../generated/i18n/app_localizations.dart';
import '../../../../../../tts_service/domain/entities/tts_state_code.dart';
import '../../../../../../tts_service/presentation/tts_settings_page/tts_settings_page.dart';
import '../../../cubit/reader_tts_cubit.dart';
import '../../../cubit/reader_tts_state.dart';

class ReaderTtsSettingsButton extends StatelessWidget {
  const ReaderTtsSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ReaderTtsCubit, ReaderTtsState>(
      buildWhen: (ReaderTtsState previous, ReaderTtsState current) =>
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderTtsState state) {
        return IconButton(
          icon: const Icon(Icons.settings_rounded),
          tooltip: appLocalizations.ttsSettingsTitle,
          onPressed: switch (state.ttsState) {
            TtsStateCode.initial => null,
            TtsStateCode.ready => () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (_) => const TtsSettingsPage())),
            TtsStateCode.playing => null,
            TtsStateCode.paused => null,
            TtsStateCode.continued => null,
            TtsStateCode.completed => () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (_) => const TtsSettingsPage())),
            TtsStateCode.canceled => () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (_) => const TtsSettingsPage())),
          },
        );
      },
    );
  }
}
