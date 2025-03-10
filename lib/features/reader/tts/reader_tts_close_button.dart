import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/reader_navigation_state_code.dart';
import '../../../generated/i18n/app_localizations.dart';
import '../cubit/reader_cubit.dart';

class ReaderTtsCloseButton extends StatelessWidget {
  const ReaderTtsCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.ttsState != current.ttsState,
      builder: (context, state) {
        final isEnabled = state.ttsState.isStopped;
        return IconButton(
          icon: const Icon(Icons.close),
          tooltip: appLocalizations.readerTtsCloseButton,
          onPressed: isEnabled
              ? () => cubit.setNavState(ReaderNavigationStateCode.defaultState)
              : null,
        );
      },
    );
  }
}
