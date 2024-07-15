import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderJumpToBookmarkButton extends StatelessWidget {
  const ReaderJumpToBookmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
      previous.readerSettings.autoSave != current.readerSettings.autoSave ||
          previous.bookmarkData.chapterNumber != current.bookmarkData.chapterNumber,
      builder: (BuildContext context, ReaderState state) {
        final bool isDisabled =
            state.bookmarkData.chapterNumber != state.chapterNumber || state.readerSettings.autoSave;
        return IconButton(
          icon: Icon(
            Icons.bookmark_rounded,
            semanticLabel: AppLocalizations.of(context)!.accessibilityReaderBookmarkButton,
          ),
          onPressed: isDisabled ? null : BlocProvider.of<ReaderCubit>(context).scrollToBookmark,
        );
      },
    );
  }
}