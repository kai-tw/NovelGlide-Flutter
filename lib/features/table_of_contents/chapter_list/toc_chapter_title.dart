import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/chapter_data.dart';
import '../bloc/toc_chapter_title_bloc.dart';

class TocChapterTitle extends StatelessWidget {
  final ChapterData chapterData;

  const TocChapterTitle(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TocChapterTitleCubit(),
      child: BlocBuilder<TocChapterTitleCubit, TocChapterTitleState>(
        builder: (BuildContext context, TocChapterTitleState state) {
          BlocProvider.of<TocChapterTitleCubit>(context).refresh(chapterData);
          final String localizedOrdinalNum = AppLocalizations.of(context)!.chapterLabelFunction(state.chapterNumber);
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: state.chapterNumber == 0 ? 0.0 : 1.0,
            child: Text(
              localizedOrdinalNum + (state.title.isNotEmpty ? " - ${state.title}" : ""),
              textAlign: TextAlign.left,
            ),
          );
        },
      ),
    );
  }
}