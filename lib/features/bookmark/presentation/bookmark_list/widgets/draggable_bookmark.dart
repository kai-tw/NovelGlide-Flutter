part of '../bookmark_list.dart';

class _DraggableBookmark extends StatelessWidget {
  const _DraggableBookmark({
    required this.bookmarkData,
    required this.isDraggable,
  });

  final BookmarkData bookmarkData;
  final bool isDraggable;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return LongPressDraggable<BookmarkData>(
        onDragStarted: () => cubit.setDragging(true),
        onDragEnd: (_) => cubit.setDragging(false),
        onDragCompleted: () async {
          BookmarkRepository.delete(bookmarkData);
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
          child: _BookmarkWidget(bookmarkData),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          child: _BookmarkWidget(bookmarkData),
        ),
        child: _BookmarkWidget(
          bookmarkData,
          onTap: () {
            Navigator.of(context)
                .push(
                  RouteUtils.pushRoute(
                    ReaderWidget(
                      bookPath: bookmarkData.bookPath,
                      destinationType: ReaderDestinationType.bookmark,
                      destination: bookmarkData.startCfi,
                    ),
                  ),
                )
                .then((_) => cubit.refresh());
          },
        ),
      );
    });
  }
}
