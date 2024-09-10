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
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.atStart != current.atStart ||
          previous.atEnd != current.atEnd ||
          previous.isRtl != current.isRtl,
      builder: (BuildContext context, ReaderState state) {
        final bool isDisabled =
            state.code != ReaderStateCode.loaded || (state.isRtl && state.atEnd) || (!state.isRtl && state.atStart);
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!.accessibilityReaderPrevChapterButton,
          ),
          onPressed: isDisabled ? null : state.isRtl ? () => cubit.nextPage() : () => cubit.prevPage(),
        );
      },
    );
  }
}
