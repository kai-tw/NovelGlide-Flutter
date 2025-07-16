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
          previous.isAscending != current.isAscending ||
          previous.sortOrder != current.sortOrder,
      builder: (BuildContext context, BookshelfState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.backgroundLoading:
          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return SharedListSliverEmpty(
                title: appLocalizations.bookshelfNoBook,
              );
            } else {
              return _buildList(context, state);
            }
        }
      },
    );
  }

  Widget _buildList(BuildContext context, BookshelfState state) {
    // Avoid books from being covered by the navigation bar.
    final double bottomPadding = MediaQuery.paddingOf(context).bottom + 48.0;
    return SliverPadding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      sliver: SharedList(
        listType: state.listType,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150.0,
          childAspectRatio: 150 / 300,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) =>
              BookshelfSliverListItem(bookData: state.dataList[index]),
          childCount: state.dataList.length,
        ),
      ),
    );
  }
}
