import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderPreviousChapterButton extends StatelessWidget {
  const ReaderPreviousChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.atStart != current.atStart,
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!.accessibilityReaderPrevChapterButton,
          ),
          onPressed: state.atStart ? null : () => cubit.prevPage(),
        );
      },
    );
  }
}
