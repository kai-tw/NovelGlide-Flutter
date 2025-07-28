part of '../../../bookmark_service.dart';

class BookmarkListDraggableBookmark extends StatelessWidget {
  const BookmarkListDraggableBookmark({
    super.key,
    required this.bookmarkData,
    required this.listType,
    required this.isDraggable,
    this.isSelecting = false,
    this.isSelected = false,
    this.onChanged,
  });

  final BookmarkData bookmarkData;
  final SharedListType listType;
  final bool isDraggable;
  final bool isSelecting;
  final bool isSelected;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double? contraintHeight =
          listType == SharedListType.grid ? constraints.maxHeight : null;
      final EdgeInsets padding = listType == SharedListType.grid
          ? const EdgeInsets.all(8.0)
          : EdgeInsets.zero;

      return LongPressDraggable<BookmarkData>(
        onDragStarted: () {
          cubit.isDragging = true;
          homepageCubit.isEnabled = false;
        },
        onDragEnd: (_) {
          cubit.isDragging = false;
          homepageCubit.isEnabled = true;
        },
        onDragCompleted: () async {
          BookmarkService.repository.deleteData(bookmarkData);
          cubit.refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.deleteBookmarkSuccessfully),
            ),
          );
        },
        data: bookmarkData,
        maxSimultaneousDrags: isDraggable ? 1 : 0,
        feedback: DraggableFeedbackWidget(
          width: constraints.maxWidth,
          height: contraintHeight,
          padding: padding,
          child: BookmarkListBookmarkWidget(
            bookmarkData: bookmarkData,
            listType: listType,
          ),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          height: contraintHeight,
          padding: padding,
          child: BookmarkListBookmarkWidget(
            bookmarkData: bookmarkData,
            listType: listType,
          ),
        ),
        child: Container(
          width: constraints.maxWidth,
          height: contraintHeight,
          padding: padding,
          child: BookmarkListBookmarkWidget(
            bookmarkData: bookmarkData,
            listType: listType,
            isSelected: isSelected,
            isSelecting: isSelecting,
            onChanged: onChanged,
          ),
        ),
      );
    });
  }
}
