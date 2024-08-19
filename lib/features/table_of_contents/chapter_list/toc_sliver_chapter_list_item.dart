import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/chapter_data.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';

class TocSliverChapterListItem extends StatelessWidget {
  final ChapterData chapterData;

  const TocSliverChapterListItem(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final int chapterNumber = chapterData.ordinalNumber;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
      child: BlocBuilder<TocCubit, TocState>(
        buildWhen: (previous, current) => previous.bookmarkData?.chapterNumber != current.bookmarkData?.chapterNumber,
        builder: (BuildContext context, TocState state) {
          final String localizedOrdinalNum = AppLocalizations.of(context)!.chapterLabel(chapterData.ordinalNumber);
          final bool isBookmarked = chapterNumber == state.bookmarkData?.chapterNumber;
          return ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ReaderWidget(cubit.bookData, chapterNumber)))
                  .then((_) => cubit.refresh());
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            leading: Icon(
              isBookmarked ? Icons.bookmark_rounded : Icons.numbers_rounded,
              color: isBookmarked ? Theme.of(context).colorScheme.error : null,
            ),
            title: Text("$localizedOrdinalNum - ${chapterData.title}"),
          );
        },
      ),
    );
  }
}
