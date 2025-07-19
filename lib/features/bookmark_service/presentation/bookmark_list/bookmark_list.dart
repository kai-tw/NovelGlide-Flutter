part of '../../bookmark_service.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    BlocProvider.of<BookmarkListCubit>(context).refresh();

    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      buildWhen: (BookmarkListState previous, BookmarkListState current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.listType != current.listType,
      builder: (BuildContext context, BookmarkListState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            // Loading
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              // No bookmarks
              return SharedListSliverEmpty(
                title: appLocalizations.bookmarkListNoBookmark,
              );
            } else {
              // Show bookmarks
              return SliverPadding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.paddingOf(context).bottom,
                ),
                sliver: SharedList(
                  listType: state.listType,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0,
                    childAspectRatio: 150 / 180,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return BookmarkListItem(
                        bookmarkData: state.dataList[index],
                      );
                    },
                    childCount: state.dataList.length,
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
