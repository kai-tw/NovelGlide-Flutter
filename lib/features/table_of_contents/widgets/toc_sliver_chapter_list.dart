import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/chapter_data.dart';
import '../../../data/loading_state_code.dart';
import '../../../toolbox/route_helper.dart';
import '../../common_components/common_list_empty.dart';
import '../../common_components/common_loading.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';

class TocSliverChapterList extends StatelessWidget {
  final BookData bookData;

  const TocSliverChapterList({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TocCubit, TocState>(
      buildWhen: (previous, current) => previous.code != current.code || previous.chapterList != current.chapterList,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();
          case LoadingStateCode.loaded:
            if (state.chapterList.isEmpty) {
              return const CommonSliverListEmpty();
            } else {
              final TocCubit cubit = BlocProvider.of<TocCubit>(context);
              final List<_TocChapterListItem> allChapterList = _constructList(state.chapterList, 0);

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ChapterData chapterData = allChapterList[index].chapterData;
                    final int nestingLevel = allChapterList[index].nestingLevel;

                    return ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(RouteHelper.pushRoute(
                              ReaderWidget(
                                bookData: bookData,
                                bookPath: bookData.filePath,
                                gotoDestination: chapterData.fileName,
                              ),
                            ))
                            .then((_) => cubit.refresh());
                      },
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 12.0 + 16 * nestingLevel, right: 12.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      leading: BlocBuilder<TocCubit, TocState>(
                        builder: (context, state) {
                          final bool isBookmarked = state.bookmarkData?.chapterFileName == chapterData.fileName;
                          return Icon(
                            isBookmarked ? Icons.bookmark_rounded : Icons.numbers_rounded,
                            color: isBookmarked ? Theme.of(context).colorScheme.secondary : null,
                            size: 20.0,
                          );
                        },
                      ),
                      title: Text(chapterData.title, style: Theme.of(context).textTheme.bodyLarge),
                    );
                  },
                  childCount: allChapterList.length,
                ),
              );
            }
        }
      },
    );
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
