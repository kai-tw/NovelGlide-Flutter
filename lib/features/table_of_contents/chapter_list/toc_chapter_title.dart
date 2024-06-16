import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/chapter_data.dart';
import '../bloc/toc_chapter_title_bloc.dart';

class TOCChapterTitle extends StatelessWidget {
  final ChapterData chapterData;

  const TOCChapterTitle(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TOCChapterTitleCubit(),
      child: BlocBuilder<TOCChapterTitleCubit, TOCChapterTitleState>(
        builder: (BuildContext context, TOCChapterTitleState state) {
          BlocProvider.of<TOCChapterTitleCubit>(context).refresh(chapterData);
          final String localizedOrdinalNum = AppLocalizations.of(context)!.chapterLabelFunction(state.chapterNumber);
          return Text(
            localizedOrdinalNum + (state.title.isNotEmpty ? " - ${state.title}" : ""),
            textAlign: TextAlign.left,
          );
        },
      ),
    );
  }
}