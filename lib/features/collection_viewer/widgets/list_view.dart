part of '../collection_viewer.dart';

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CollectionViewerCubit>(context);
    return BlocBuilder<CollectionViewerCubit, CommonListState<BookData>>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.isSelecting != current.isSelecting,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonLoading();

          case LoadingStateCode.backgroundLoading:
            return Column(
              children: [
                const LinearProgressIndicator(),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.dataList.length,
                    itemBuilder: (context, index) {
                      return _ListItem(
                        bookData: state.dataList[index],
                        isDraggable: false,
                      );
                    },
                  ),
                ),
              ],
            );

          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return const CommonListEmpty();
            } else {
              return ReorderableListView.builder(
                onReorder: cubit.reorder,
                buildDefaultDragHandles:
                    !state.isSelecting && state.dataList.length > 1,
                itemCount: state.dataList.length,
                itemBuilder: (context, index) {
                  final data = state.dataList[index];
                  return _ListItem(
                    bookData: data,
                    key: ValueKey(data.absoluteFilePath),
                    isSelecting: state.isSelecting,
                  );
                },
              );
            }
        }
      },
    );
  }
}
