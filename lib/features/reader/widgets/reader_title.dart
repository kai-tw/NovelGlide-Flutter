import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderTitle extends StatelessWidget {
  const ReaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.chapterNumber != current.chapterNumber,
      builder: (BuildContext context, ReaderState state) {
        return Text(AppLocalizations.of(context)!.chapterLabelFunction(state.chapterNumber));
      },
    );
  }
}
