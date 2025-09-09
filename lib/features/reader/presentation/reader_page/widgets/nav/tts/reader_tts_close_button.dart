import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../generated/i18n/app_localizations.dart';
import '../../../../../../tts_service/domain/entities/tts_state_code.dart';
import '../../../../../domain/entities/reader_navigation_state_code.dart';
import '../../../cubit/reader_cubit.dart';
import '../../../cubit/reader_tts_cubit.dart';
import '../../../cubit/reader_tts_state.dart';

class ReaderTtsCloseButton extends StatelessWidget {
  const ReaderTtsCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);

    return BlocBuilder<ReaderTtsCubit, ReaderTtsState>(
      buildWhen: (ReaderTtsState previous, ReaderTtsState current) =>
          previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderTtsState state) {
        return IconButton(
          icon: const Icon(Icons.close),
          tooltip: appLocalizations.readerTtsCloseButton,
          onPressed: switch (state.ttsState) {
            TtsStateCode.initial => () =>
                cubit.setNavState(ReaderNavigationStateCode.defaultState),
            TtsStateCode.ready => () =>
                cubit.setNavState(ReaderNavigationStateCode.defaultState),
            TtsStateCode.playing => null,
            TtsStateCode.paused => null,
            TtsStateCode.continued => null,
            TtsStateCode.completed => () =>
                cubit.setNavState(ReaderNavigationStateCode.defaultState),
            TtsStateCode.canceled => () =>
                cubit.setNavState(ReaderNavigationStateCode.defaultState),
          },
        );
      },
    );
  }
}
