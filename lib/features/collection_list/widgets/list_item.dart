part of '../collection_list.dart';

class _ListItem extends StatelessWidget {
  final CollectionData _collectionData;

  const _ListItem(this._collectionData);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CollectionListCubit>(context);
    return BlocBuilder<CollectionListCubit, _State>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.selectedSet.contains(_collectionData) !=
              current.selectedSet.contains(_collectionData),
      builder: (context, state) {
        if (state.isSelecting) {
          final isSelected = state.selectedSet.contains(_collectionData);
          return _CollectionWidget(
            _collectionData,
            isSelecting: state.isSelecting,
            isSelected: isSelected,
            onChanged: (bool? value) {
              if (value == true) {
                cubit.selectSingle(_collectionData);
              } else {
                cubit.deselectSingle(_collectionData);
              }
            },
          );
        } else {
          return _DraggableCollection(_collectionData);
        }
      },
    );
  }
}
