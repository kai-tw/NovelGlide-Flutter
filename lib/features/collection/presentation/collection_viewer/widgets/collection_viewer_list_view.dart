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
              previous.dataList != current.dataList,
      builder: (BuildContext context, CollectionViewerState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonLoadingWidget();

          case LoadingStateCode.error:
            // Error
            return const CommonErrorWidget();

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
                buildDefaultDragHandles: false,
                itemCount: state.dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  final Book book = state.dataList[index];
                  return CollectionViewerListItem(
                    bookData: book,
                    index: index,
                    key: ValueKey<String>(book.identifier),
                  );
                },
              );
            }
        }
      },
    );
  }
}
