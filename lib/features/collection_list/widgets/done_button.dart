part of '../collection_list.dart';

class _DoneButton extends StatelessWidget {
  const _DoneButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    return BlocBuilder<CollectionListCubit, _State>(
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
