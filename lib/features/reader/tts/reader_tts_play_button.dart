import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n/app_localizations.dart';
import '../cubit/reader_cubit.dart';

class ReaderTtsPlayButton extends StatelessWidget {
  const ReaderTtsPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      tooltip: "Play",
      onPressed: () => print("Play"),
    );
  }
}
