part of '../bookmark_list.dart';

class _ListItem extends StatelessWidget {
  const _ListItem(this._bookmarkData);

  final BookmarkData _bookmarkData;

  @override
  Widget build(BuildContext context) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, CommonListState<BookmarkData>>(
      buildWhen: (CommonListState<BookmarkData> previous,
              CommonListState<BookmarkData> current) =>
          previous.isSelecting != current.isSelecting ||
          previous.selectedSet.contains(_bookmarkData) !=
              current.selectedSet.contains(_bookmarkData),
      builder: (BuildContext context, CommonListState<BookmarkData> state) {
        if (state.isSelecting) {
          final bool isSelected = state.selectedSet.contains(_bookmarkData);
          return _BookmarkWidget(
            _bookmarkData,
            isSelecting: state.isSelecting,
            isSelected: isSelected,
            onChanged: (bool? value) {
              if (value == true) {
                cubit.selectSingle(_bookmarkData);
              } else {
                cubit.deselectSingle(_bookmarkData);
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
