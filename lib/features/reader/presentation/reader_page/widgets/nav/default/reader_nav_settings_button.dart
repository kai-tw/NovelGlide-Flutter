import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../generated/i18n/app_localizations.dart';
import '../../../../settings_bottom_sheet/reader_bottom_sheet.dart';
import '../../../cubit/reader_cubit.dart';
import '../../../cubit/reader_tts_cubit.dart';
import '../../../cubit/reader_tts_state.dart';

class ReaderNavSettingsButton extends StatelessWidget {
  const ReaderNavSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code,
      builder: (BuildContext context, ReaderState state) {
        return BlocBuilder<ReaderTtsCubit, ReaderTtsState>(
          buildWhen: (ReaderTtsState previous, ReaderTtsState current) =>
              previous.ttsState != current.ttsState,
          builder: (BuildContext context, ReaderTtsState ttsState) {
            final bool isEnabled =
                state.code.isLoaded || ttsState.ttsState.isIdle;
            return IconButton(
              icon: const Icon(Icons.settings_rounded),
              tooltip: appLocalizations.readerSettings,
              onPressed: isEnabled
                  ? () => _navigateToSettingsPage(context, cubit)
                  : null,
            );
          },
        );
      },
    );
  }

  void _navigateToSettingsPage(BuildContext context, ReaderCubit cubit) {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1.0,
      showDragHandle: true,
      barrierColor:
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      builder: (BuildContext context) {
        return BlocProvider<ReaderCubit>.value(
          value: cubit,
          child: const ReaderBottomSheet(),
        );
      },
    );
  }
}
