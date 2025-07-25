part of '../../../bookmark_service.dart';

class BookmarkListItem extends StatelessWidget {
  const BookmarkListItem({super.key, required this.bookmarkData});

  final BookmarkData bookmarkData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(24.0),
      child: Semantics(
        label: appLocalizations.generalBookmark(1),
        onTapHint: appLocalizations.bookmarkListStartReading,
        onLongPressHint: appLocalizations.bookmarkListDragToDelete,
        child: BlocBuilder<BookmarkListCubit, BookmarkListState>(
          buildWhen: (BookmarkListState previous, BookmarkListState current) =>
              previous.code != current.code ||
              previous.isSelecting != current.isSelecting ||
              previous.isDragging != current.isDragging ||
              previous.selectedSet.contains(bookmarkData) != current.selectedSet.contains(bookmarkData) ||
              previous.listType != current.listType,
          builder: (BuildContext context, BookmarkListState state) {
            return BookmarkListDraggableBookmark(
              bookmarkData: bookmarkData,
              listType: state.listType,
              isDraggable: state.code.isLoaded && !state.isDragging && !state.isSelecting,
              isSelecting: state.isSelecting,
              isSelected: state.selectedSet.contains(bookmarkData),
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
            MaterialPageRoute<void>(
              builder: (_) => ReaderWidget(
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
