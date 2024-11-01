part of '../bookmark_list.dart';

class _ListItem extends StatelessWidget {
  final BookmarkData _bookmarkData;

  const _ListItem(this._bookmarkData);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookmarkListCubit>(context);

    return BlocBuilder<BookmarkListCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.selectedBookmarks.contains(_bookmarkData) !=
              current.selectedBookmarks.contains(_bookmarkData),
      builder: (context, state) {
        if (state.isSelecting) {
          final isSelected = state.selectedBookmarks.contains(_bookmarkData);
          return BookmarkWidget(
            _bookmarkData,
            isSelecting: state.isSelecting,
            isSelected: isSelected,
            onChanged: (bool? value) {
              if (value == true) {
                cubit.selectBookmark(_bookmarkData);
              } else {
                cubit.deselectBookmark(_bookmarkData);
              }
            },
          );
        } else {
          return _DraggableBookmark(_bookmarkData);
        }
      },
    );
  }
}
