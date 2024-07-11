import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderPreviousChapterButton extends StatelessWidget {
  const ReaderPreviousChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.prevChapterNumber != current.prevChapterNumber,
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!.accessibilityReaderPrevChapterButton,
          ),
          onPressed: state.prevChapterNumber == -1
              ? null
              : () => BlocProvider.of<ReaderCubit>(context).changeChapter(state.prevChapterNumber),
        );
      },
    );
  }
}
