part of '../bookmark_list.dart';

class _ListItem extends StatelessWidget {
  final BookmarkData _bookmarkData;

  const _ListItem(this._bookmarkData);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, HomepageListState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.selectedSet.contains(_bookmarkData) !=
              current.selectedSet.contains(_bookmarkData),
      builder: (context, state) {
        if (state.isSelecting) {
          final isSelected = state.selectedSet.contains(_bookmarkData);
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
