part of '../collection_list.dart';

class _SelectButton extends StatelessWidget {
  const _SelectButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    return BlocBuilder<CollectionListCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.collectionList.isNotEmpty !=
              current.collectionList.isNotEmpty ||
          previous.isSelectAll != current.isSelectAll,
      builder: (context, state) {
        return CommonListSelectButton(
          isVisible: state.isSelecting,
          enabled: state.collectionList.isNotEmpty,
          isSelectAll: state.isSelectAll,
          selectAll: cubit.selectAll,
          deselectAll: cubit.deselectAll,
        );
      },
    );
  }
}
