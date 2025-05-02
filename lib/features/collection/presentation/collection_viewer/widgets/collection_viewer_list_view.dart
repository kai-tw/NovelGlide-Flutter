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
              return ReorderableListView.builder(
                header: state.code.isBackgroundLoading
                    ? const LinearProgressIndicator()
                    : null,
                onReorder: cubit.reorder,
                buildDefaultDragHandles: state.code.isLoaded &&
                    !state.isSelecting &&
                    state.dataList.length > 1,
                itemCount: state.dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  final BookData data = state.dataList[index];
                  return CollectionViewerListItem(
                    bookData: data,
                    key: ValueKey<String>(data.absoluteFilePath),
                    isSelecting: state.isSelecting,
                    isDraggable: state.code.isLoaded,
                  );
                },
              );
            }
        }
      },
    );
  }
}
