import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../cubit/reader_cubit.dart';

class ReaderTtsPauseButton extends StatelessWidget {
  const ReaderTtsPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return IconButton(
      icon: const Icon(Icons.pause_rounded),
      tooltip: "Pause",
      onPressed: () => print("Pause"),
    );
  }
}
