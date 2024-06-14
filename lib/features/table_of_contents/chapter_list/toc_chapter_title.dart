import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/toc_chapter_title_bloc.dart';

class TOCChapterTitle extends StatelessWidget {
  const TOCChapterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TOCChapterTitleCubit, TOCChapterTitleState>(
      builder: (BuildContext context, TOCChapterTitleState state) {
        final String localizedOrdinalNum = AppLocalizations.of(context)!.chapterLabelFunction(state.chapterNumber);
        return Text(
          localizedOrdinalNum + (state.title.isNotEmpty ? " - ${state.title}" : ""),
          textAlign: TextAlign.left,
        );
      },
    );
  }
}