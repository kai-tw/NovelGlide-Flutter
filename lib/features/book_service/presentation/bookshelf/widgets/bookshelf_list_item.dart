part of '../../../book_service.dart';

class BookshelfSliverListItem extends StatelessWidget {
  const BookshelfSliverListItem({super.key, required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(24.0),
      child: Semantics(
        label: appLocalizations.generalBook,
        onTapHint: appLocalizations.bookshelfOpenBook,
        onLongPressHint: appLocalizations.bookshelfDragToDelete,
        child: BlocBuilder<BookshelfCubit, BookshelfState>(
          buildWhen: (BookshelfState previous, BookshelfState current) =>
              previous.code != current.code ||
              previous.isSelecting != current.isSelecting ||
              previous.isDragging != current.isDragging ||
              previous.selectedSet.contains(bookData) !=
                  current.selectedSet.contains(bookData) ||
              previous.listType != current.listType,
          builder: (BuildContext context, BookshelfState state) {
            return BookshelfDraggableBook(
              bookData: bookData,
              listType: state.listType,
              isDraggable: state.code.isLoaded &&
                  !state.isDragging &&
                  !state.isSelecting,
              isSelecting: state.isSelecting,
              isSelected: state.selectedSet.contains(bookData),
              onChanged: (_) => cubit.toggleSelectSingle(bookData),
            );
          },
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    if (cubit.state.isSelecting) {
      cubit.toggleSelectSingle(bookData);
    } else if (bookData.isExist) {
      // Navigate to the table of contents page.
      Navigator.of(context)
          .push(RouteUtils.defaultRoute(TableOfContents(bookData)));
    } else {
      // Show the book is not exist dialog.
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonErrorDialog(
          content: appLocalizations.bookshelfBookNotExist,
        ),
      ).then((_) => cubit.refresh());
    }
  }
}
