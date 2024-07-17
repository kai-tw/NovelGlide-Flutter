import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chapter_data.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';
import '../chapter_list/toc_chapter_title.dart';

class TocChapterWidget extends StatelessWidget {
  final ChapterData chapterData;
  final bool isBookmarked;

  const TocChapterWidget({super.key, required this.chapterData, required this.isBookmarked});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final int chapterNumber = chapterData.ordinalNumber;
    final String bookName = chapterData.bookName;
    final double iconSize = IconTheme.of(context).size ?? 24.0;
    return TextButton.icon(
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (context) => ReaderWidget(bookName, chapterNumber),
          ))
          .then((_) => cubit.refresh()),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      icon: Icon(
        isBookmarked ? Icons.bookmark_rounded : Icons.numbers_rounded,
        size: MediaQuery.of(context).textScaler.scale(iconSize),
        color: isBookmarked ? Theme.of(context).colorScheme.error : null,
      ),
      label: TocChapterTitle(chapterData),
    );
  }
}