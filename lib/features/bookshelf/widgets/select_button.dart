part of '../bookshelf.dart';

class _SelectButton extends StatelessWidget {
  const _SelectButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.dataList.isNotEmpty != current.dataList.isNotEmpty ||
          previous.isSelectAll != current.isSelectAll,
      builder: (context, state) {
        return CommonListSelectButton(
          isVisible: state.isSelecting,
          enabled: state.dataList.isNotEmpty,
          isSelectAll: state.isSelectAll,
          selectAll: cubit.selectAllBooks,
          deselectAll: cubit.deselectAllBooks,
        );
      },
    );
  }
}
