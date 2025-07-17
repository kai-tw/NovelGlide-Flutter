part of '../../book_service.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    BlocProvider.of<BookshelfCubit>(context).refresh();

    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (BookshelfState previous, BookshelfState current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.listType != current.listType,
      builder: (BuildContext context, BookshelfState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            // Loading...
            return const CommonSliverLoading();

          case LoadingStateCode.backgroundLoading:
          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              // No books.
              return SharedListSliverEmpty(
                title: appLocalizations.bookshelfNoBook,
              );
            } else {
              // Show books.
              return SliverPadding(
                padding: EdgeInsets.only(
                  // Avoid books from being covered by the navigation bar.
                  bottom: MediaQuery.paddingOf(context).bottom + 48.0,
                ),
                sliver: SharedList(
                  listType: state.listType,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0,
                    childAspectRatio: 150 / 300,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        BookshelfSliverListItem(
                            bookData: state.dataList[index]),
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
