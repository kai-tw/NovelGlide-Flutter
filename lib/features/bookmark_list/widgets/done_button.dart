part of '../bookmark_list.dart';

class _DoneButton extends StatelessWidget {
  const _DoneButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookmarkListCubit>(context);
    return BlocBuilder<BookmarkListCubit, CommonListState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting,
      builder: (context, state) {
        return CommonListDoneButton(
          isVisible: state.isSelecting,
          onPressed: () => cubit.setSelecting(false),
        );
      },
    );
  }
}
