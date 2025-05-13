part of '../table_of_contents.dart';

class _SliverList extends StatelessWidget {
  const _SliverList({required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (_State previous, _State current) =>
          previous.code != current.code ||
          previous.chapterList != current.chapterList ||
          previous.bookmarkData != current.bookmarkData,
      builder: (BuildContext context, _State state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.chapterList.isEmpty) {
              return SharedListSliverEmpty(
                title: appLocalizations.tocNoChapter,
              );
            } else {
              return _buildList(context, state);
            }
        }
      },
    );
  }

  Widget _buildList(BuildContext context, _State state) {
    final _Cubit cubit = BlocProvider.of<_Cubit>(context);
    final List<_ListItem> allChapterList =
        _constructChapterTree(state.chapterList, 0);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final ChapterData chapterData = allChapterList[index].chapterData;
          final int nestingLevel = allChapterList[index].nestingLevel;
          final BookmarkData? bookmarkData = state.bookmarkData;
          final bool isBookmarked =
              bookmarkData?.chapterFileName == chapterData.fileName;
          final ThemeData themeData = Theme.of(context);

          return ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(
                    RouteUtils.defaultRoute(
                      ReaderWidget(
                        bookData: bookData,
                        bookPath: bookData.absoluteFilePath,
                        destination: chapterData.fileName,
                      ),
                    ),
                  )
                  .then((_) => cubit.refresh());
            },
            dense: true,
            contentPadding: EdgeInsets.only(
              left: 12.0 + 16 * nestingLevel,
              right: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            leading: Icon(
              isBookmarked ? Icons.bookmark_rounded : Icons.numbers_rounded,
              color: isBookmarked ? themeData.colorScheme.secondary : null,
              size: 20.0,
            ),
            title: Text(
              chapterData.title,
              style: themeData.textTheme.bodyLarge,
            ),
          );
        },
        childCount: allChapterList.length,
      ),
    );
  }

  /// Constructs the chapter n-ary tree.
  /// [chapterDataList] is the list of chapters to be traversed.
  /// [nestingLevel] is the nesting level of the current chapter.
  /// [nestingLevel] will be used to calculate the indentation of the chapter tile.
  List<_ListItem> _constructChapterTree(
    List<ChapterData> chapterDataList,
    int nestingLevel,
  ) {
    // Tree root
    final List<_ListItem> list = <_ListItem>[];

    // Traverse the sub chapters
    for (final ChapterData data in chapterDataList) {
      list.add(_ListItem(
        chapterData: data,
        nestingLevel: nestingLevel,
      ));

      // If the chapter has sub chapters, traverse them
      if (data.subChapterList != null) {
        list.addAll(
          _constructChapterTree(
            data.subChapterList!,
            nestingLevel + 1,
          ),
        );
      }
    }
    return list;
  }
}

class _ListItem {
  const _ListItem({
    required this.chapterData,
    required this.nestingLevel,
  });

  final ChapterData chapterData;
  final int nestingLevel;
}
