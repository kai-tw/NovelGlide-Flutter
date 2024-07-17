import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderNextChapterButton extends StatelessWidget {
  const ReaderNextChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.nextChapterNumber != current.nextChapterNumber,
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!.accessibilityReaderNextChapterButton,
          ),
          onPressed: state.nextChapterNumber == -1 ? null : () => _onPressed(context, state.nextChapterNumber),
        );
      },
    );
  }

  void _onPressed(BuildContext context, int chapterNumber) {
    BlocProvider.of<ReaderCubit>(context).changeChapter(chapterNumber);
  }
}
