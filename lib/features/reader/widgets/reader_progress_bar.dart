import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_progress_bar_bloc.dart';

class ReaderProgressBar extends StatelessWidget {
  const ReaderProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderProgressBarCubit, ReaderProgressBarState>(
      builder: (BuildContext context, ReaderProgressBarState state) {
        return LinearProgressIndicator(
          value: state.currentScrollY / state.maxScrollY,
          backgroundColor: Theme.of(context).colorScheme.surface,
          valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
          semanticsLabel: AppLocalizations.of(context)!.accessibilityReadingProgressBar,
          semanticsValue: "${state.currentScrollY / state.maxScrollY}%",
        );
      },
    );
  }
}