import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/toc_chapter_title_bloc.dart';

class TOCChapterTitle extends StatelessWidget {
  final int chapterNumber;

  const TOCChapterTitle({super.key, required this.chapterNumber});

  @override
  Widget build(BuildContext context) {
    final String localizedOrdinalNum = AppLocalizations.of(context)!.chapterLabelFunction(chapterNumber);
    BlocProvider.of<TOCChapterTitleCubit>(context).refresh();

    return BlocBuilder<TOCChapterTitleCubit, TOCChapterTitleState>(
      builder: (BuildContext context, TOCChapterTitleState state) {
        return Text(
          localizedOrdinalNum + (state.title.isNotEmpty ? " - ${state.title}" : ""),
          textAlign: TextAlign.left,
        );
      },
    );
  }

}