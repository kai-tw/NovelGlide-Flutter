part of '../../../bookmark_service.dart';

class BookmarkListItem extends StatelessWidget {
  const BookmarkListItem({super.key, required this.bookmarkData});

  final BookmarkData bookmarkData;

  @override
  Widget build(BuildContext context) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(24.0),
      child: Semantics(
        // TODO(kai): Semantics.
        child: BlocBuilder<BookmarkListCubit, BookmarkListState>(
          buildWhen: (BookmarkListState previous, BookmarkListState current) =>
              previous.isSelecting != current.isSelecting ||
              previous.isDragging != current.isDragging ||
              previous.selectedSet.contains(bookmarkData) !=
                  current.selectedSet.contains(bookmarkData) ||
              previous.listType != current.listType,
          builder: (BuildContext context, BookmarkListState state) {
            final bool isSelected = state.selectedSet.contains(bookmarkData);
            return BookmarkListDraggableBookmark(
              bookmarkData: bookmarkData,
              listType: state.listType,
              isDraggable: state.code.isLoaded &&
                  !state.isDragging &&
                  !state.isSelecting,
              isSelecting: state.isSelecting,
              isSelected: isSelected,
              onChanged: (_) => cubit.toggleSelectSingle(bookmarkData),
            );
          },
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    if (cubit.state.isSelecting) {
      cubit.toggleSelectSingle(bookmarkData);
    } else {
      Navigator.of(context)
          .push(
            RouteUtils.defaultRoute(
              ReaderWidget(
                bookPath: bookmarkData.bookPath,
                destinationType: ReaderDestinationType.bookmark,
                destination: bookmarkData.startCfi,
              ),
            ),
          )
          .then((_) => cubit.refresh());
    }
  }
}
