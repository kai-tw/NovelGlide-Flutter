part of '../bookmark_list.dart';

class _DraggableBookmark extends StatelessWidget {
  const _DraggableBookmark(this._data);

  final BookmarkData _data;

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
          BookmarkRepository.delete(_data);
          cubit.refresh();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.deleteBookmarkSuccessfully),
            ),
          );
        },
        data: _data,
        feedback: DraggableFeedbackWidget(
          width: constraints.maxWidth,
          child: _BookmarkWidget(_data),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          child: _BookmarkWidget(_data),
        ),
        child: _BookmarkWidget(
          _data,
          onTap: () {
            Navigator.of(context)
                .push(
                  RouteUtils.pushRoute(
                    ReaderWidget(
                      bookPath: _data.bookPath,
                      destinationType: ReaderDestinationType.bookmark,
                      destination: _data.startCfi,
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
