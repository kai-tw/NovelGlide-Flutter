part of '../collection_viewer.dart';

class _ListItem extends StatelessWidget {
  const _ListItem({
    super.key,
    required this.bookData,
    this.isSelecting = false,
    this.isDraggable = true,
  });

  final BookData bookData;
  final bool isSelecting;
  final bool isDraggable;

  @override
  Widget build(BuildContext context) {
    final CollectionViewerCubit cubit =
        BlocProvider.of<CollectionViewerCubit>(context);
    if (isSelecting) {
      return BlocBuilder<CollectionViewerCubit, CommonListState<BookData>>(
        key: key,
        buildWhen: (CommonListState<BookData> previous,
                CommonListState<BookData> current) =>
            previous.selectedSet.contains(bookData) !=
            current.selectedSet.contains(bookData),
        builder: (BuildContext context, CommonListState<BookData> state) {
          return CommonListSelectableListTile(
            isSelecting: isSelecting,
            isSelected: state.selectedSet.contains(bookData),
            onChanged: (bool? value) {
              if (value == true) {
                cubit.selectSingle(bookData);
              } else {
                cubit.deselectSingle(bookData);
              }
            },
            leading: const Icon(Icons.book_outlined),
            title: Text(bookData.name),
            trailing: const Icon(Icons.drag_handle_rounded),
          );
        },
      );
    } else {
      return CommonListSelectableListTile(
        onTap: () {
          Navigator.of(context)
              .push(RouteUtils.pushRoute(TableOfContents(bookData)))
              .then((_) => cubit.refresh());
        },
        leading: const Icon(Icons.book_outlined),
        title: Text(bookData.name),
        trailing: isDraggable ? const Icon(Icons.drag_handle_rounded) : null,
      );
    }
  }
}
