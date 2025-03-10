part of '../table_of_contents.dart';

class _SliverList extends StatelessWidget {
  final BookData bookData;

  const _SliverList({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.chapterList != current.chapterList ||
          previous.bookmarkData != current.bookmarkData,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.chapterList.isEmpty) {
              return CommonSliverListEmpty(
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
    final cubit = BlocProvider.of<_Cubit>(context);
    final allChapterList = _constructChapterTree(state.chapterList, 0);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final chapterData = allChapterList[index].chapterData;
          final nestingLevel = allChapterList[index].nestingLevel;
          final bookmarkData = state.bookmarkData;
          final isBookmarked =
              bookmarkData?.chapterFileName == chapterData.fileName;
          final themeData = Theme.of(context);

          return ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(
                    RouteUtils.pushRoute(
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
    List<_ListItem> list = [];

    // Traverse the sub chapters
    for (final data in chapterDataList) {
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
  final ChapterData chapterData;
  final int nestingLevel;

  const _ListItem({
    required this.chapterData,
    required this.nestingLevel,
  });
}
