part of '../collection_viewer.dart';

class CollectionViewerListItem extends StatelessWidget {
  const CollectionViewerListItem({
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
    return BlocBuilder<CollectionViewerCubit, CollectionViewerState>(
      buildWhen:
          (CollectionViewerState previous, CollectionViewerState current) =>
              previous.selectedSet.contains(bookData) !=
              current.selectedSet.contains(bookData),
      builder: (BuildContext context, CollectionViewerState state) {
        return CommonListSelectableListTile(
          isSelecting: isSelecting,
          isSelected: state.selectedSet.contains(bookData),
          onTap: () => _onTap(context),
          onChanged: (_) => _onChanged(context),
          leading: const Icon(Icons.book_outlined),
          title: Text(bookData.name),
          trailing: isDraggable ? const Icon(Icons.drag_handle_rounded) : null,
        );
      },
    );
  }

  void _onTap(BuildContext context) {
    final CollectionViewerCubit cubit =
        BlocProvider.of<CollectionViewerCubit>(context);
    Navigator.of(context)
        .push(RouteUtils.pushRoute(TableOfContents(bookData)))
        .then((_) => cubit.refresh());
  }

  void _onChanged(BuildContext context) {
    final CollectionViewerCubit cubit =
        BlocProvider.of<CollectionViewerCubit>(context);
    if (cubit.state.selectedSet.contains(bookData)) {
      cubit.deselectSingle(bookData);
    } else {
      cubit.selectSingle(bookData);
    }
  }
}
