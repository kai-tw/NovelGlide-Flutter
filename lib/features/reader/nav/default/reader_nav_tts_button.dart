import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/reader_navigation_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../bloc/reader_cubit.dart';
import '../../bloc/reader_state.dart';

class ReaderNavTtsButton extends StatelessWidget {
  const ReaderNavTtsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final cubit = BlocProvider.of<ReaderCubit>(context);
        return IconButton(
          icon: Icon(
            Icons.volume_up,
            semanticLabel: appLocalizations.accessibilityReaderBookmarkButton,
          ),
          onPressed: state.code.isLoaded
              ? () => cubit.setNavState(ReaderNavigationStateCode.ttsState)
              : null,
        );
      },
    );
  }
}
