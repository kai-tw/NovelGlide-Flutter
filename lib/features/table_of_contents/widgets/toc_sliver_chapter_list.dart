import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../../data/chapter_data.dart';
import '../../common_components/common_list_empty.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';

class TocSliverChapterList extends StatelessWidget {
  final BookData bookData;

  const TocSliverChapterList({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    if (bookData.chapterList?.isEmpty ?? true) {
      return const CommonSliverListEmpty();
    } else {
      final TocCubit cubit = BlocProvider.of<TocCubit>(context);
      final List<_TocChapterListItem> allChapterList = _constructList(bookData.chapterList!, 0);

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final ChapterData chapterData = allChapterList[index].chapterData;
            final int nestingLevel = allChapterList[index].nestingLevel;

            return Semantics(
              label: AppLocalizations.of(context)!.accessibilityTocListItem,
              onTapHint: AppLocalizations.of(context)!.accessibilityTocListItemOnTap,
              onLongPressHint: AppLocalizations.of(context)!.accessibilityTocListItemOnLongPress,
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => ReaderWidget(
                                bookData: bookData,
                                bookPath: bookData.filePath,
                                gotoDestination: chapterData.fileName,
                              )))
                      .then((_) => cubit.refresh());
                },
                dense: true,
                contentPadding: EdgeInsets.only(left: 12.0 + 16 * nestingLevel, right: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                leading: const Icon(Icons.numbers_rounded, size: 20.0),
                title: Text(chapterData.title, style: Theme.of(context).textTheme.bodyLarge),
              ),
            );
          },
          childCount: allChapterList.length,
        ),
      );
    }
  }

  List<_TocChapterListItem> _constructList(List<ChapterData> chapterDataList, int nestingLevel) {
    List<_TocChapterListItem> list = [];
    for (ChapterData data in chapterDataList) {
      list.add(_TocChapterListItem(chapterData: data, nestingLevel: nestingLevel));
      if (data.subChapterList != null) {
        list.addAll(_constructList(data.subChapterList!, nestingLevel + 1));
      }
    }
    return list;
  }
}

class _TocChapterListItem {
  final ChapterData chapterData;
  final int nestingLevel;

  const _TocChapterListItem({required this.chapterData, required this.nestingLevel});
}
