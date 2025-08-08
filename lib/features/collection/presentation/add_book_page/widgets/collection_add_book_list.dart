part of '../../../collection_service.dart';

class CollectionAddBookList extends StatelessWidget {
  const CollectionAddBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionAddBookCubit, CollectionAddBookState>(
      buildWhen:
          (CollectionAddBookState previous, CollectionAddBookState current) =>
              previous.code != current.code ||
              previous.collectionList != current.collectionList ||
              previous.selectedCollections != current.selectedCollections,
      builder: _buildList,
    );
  }

  Widget _buildList(BuildContext context, CollectionAddBookState state) {
    switch (state.code) {
      case LoadingStateCode.initial:
      case LoadingStateCode.loading:
      case LoadingStateCode.backgroundLoading:
        // Loading...
        return const CommonLoading();

      case LoadingStateCode.loaded:
        if (state.collectionList.isEmpty) {
          // There is no collection.
          return const SharedListEmpty();
        } else {
          return ListView.builder(
            itemCount: state.collectionList.length,
            itemBuilder: (BuildContext context, int index) {
              final CollectionData data = state.collectionList[index];
              final bool? isSelected = state.selectedCollections.contains(data)
                  ? state.selectedCollections.every((CollectionData e) => e
                          .pathList
                          .toSet()
                          .containsAll(state.bookRelativePathSet))
                      ? true
                      : null
                  : false;

              return CollectionAddBookListItem(
                data: data,
                isSelected: isSelected,
              );
            },
          );
        }
    }
  }
}
