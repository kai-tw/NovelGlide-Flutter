import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderProgressBar extends StatelessWidget {
  const ReaderProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.currentScrollY != current.currentScrollY || previous.maxScrollExtent != current.maxScrollExtent,
      builder: (BuildContext context, ReaderState state) {
        return LinearProgressIndicator(
          value: state.currentScrollY / state.maxScrollExtent,
          backgroundColor: Theme.of(context).colorScheme.surface,
          valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
          semanticsLabel: AppLocalizations.of(context)!.accessibilityReadingProgressBar,
          semanticsValue: "${state.currentScrollY / state.maxScrollExtent * 100}%",
        );
      },
    );
  }
}
