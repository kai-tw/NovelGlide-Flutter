part of '../collection_viewer.dart';

class CollectionViewerListView extends StatelessWidget {
  const CollectionViewerListView({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionViewerCubit cubit =
        BlocProvider.of<CollectionViewerCubit>(context);
    return BlocBuilder<CollectionViewerCubit, CollectionViewerState>(
      buildWhen:
          (CollectionViewerState previous, CollectionViewerState current) =>
              previous.code != current.code ||
              previous.dataList != current.dataList ||
              previous.isSelecting != current.isSelecting,
      builder: (BuildContext context, CollectionViewerState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonLoading();

          case LoadingStateCode.backgroundLoading:
          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return const SharedListEmpty();
            } else {
              final bool isDraggable = state.code.isLoaded &&
                  !state.isSelecting &&
                  state.dataList.length > 1;
              return ReorderableListView.builder(
                header: state.code.isBackgroundLoading
                    ? const LinearProgressIndicator()
                    : null,
                onReorder: cubit.reorder,
                buildDefaultDragHandles: isDraggable,
                itemCount: state.dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  final Book book = state.dataList[index];
                  return CollectionViewerListItem(
                    bookData: book,
                    key: ValueKey<String>(book.identifier),
                    isSelecting: state.isSelecting,
                    isDraggable: isDraggable,
                  );
                },
              );
            }
        }
      },
    );
  }
}
