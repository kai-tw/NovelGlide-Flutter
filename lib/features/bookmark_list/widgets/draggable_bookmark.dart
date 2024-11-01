part of '../bookmark_list.dart';

class _DraggableBookmark extends StatelessWidget {
  final BookmarkData _data;

  const _DraggableBookmark(this._data);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);

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
          child: BookmarkWidget(_data),
        ),
        childWhenDragging: DraggablePlaceholderWidget(
          width: constraints.maxWidth,
          child: BookmarkWidget(_data),
        ),
        child: Container(
          width: constraints.maxWidth,
          color: Colors.transparent,
          child: BookmarkWidget(_data),
        ),
      );
    });
  }
}
