part of '../bookmark_list.dart';

class _SelectButton extends StatelessWidget {
  const _SelectButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, CommonListState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.dataList.isNotEmpty != current.dataList.isNotEmpty ||
          previous.isSelectAll != current.isSelectAll,
      builder: (context, state) {
        return CommonListSelectButton(
          isVisible: state.isSelecting,
          enabled: state.dataList.isNotEmpty,
          isSelectAll: state.isSelectAll,
          selectAll: cubit.selectAllBookmarks,
          deselectAll: cubit.deselectAllBookmarks,
        );
      },
    );
  }
}
