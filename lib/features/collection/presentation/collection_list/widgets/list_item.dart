part of '../collection_list.dart';

class _ListItem extends StatelessWidget {
  const _ListItem(this._collectionData);

  final CollectionData _collectionData;

  @override
  Widget build(BuildContext context) {
    final CollectionListCubit cubit =
        BlocProvider.of<CollectionListCubit>(context);
    return BlocBuilder<CollectionListCubit, SharedListState<CollectionData>>(
      buildWhen: (SharedListState<CollectionData> previous,
              SharedListState<CollectionData> current) =>
          previous.isSelecting != current.isSelecting ||
          previous.isDragging != current.isDragging ||
          previous.selectedSet.contains(_collectionData) !=
              current.selectedSet.contains(_collectionData),
      builder: (BuildContext context, CollectionListState state) {
        if (state.isSelecting) {
          final bool isSelected = state.selectedSet.contains(_collectionData);
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
          return _DraggableCollection(
            collectionData: _collectionData,
            isDraggable: !state.isDragging,
          );
        }
      },
    );
  }
}
