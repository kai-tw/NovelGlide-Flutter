part of '../bookmark_list.dart';

class _DraggableBookmark extends StatelessWidget {
  final BookmarkData _data;

  const _DraggableBookmark(this._data);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookmarkListCubit>(context);

    return LayoutBuilder(builder: (context, constraints) {
      return LongPressDraggable(
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
