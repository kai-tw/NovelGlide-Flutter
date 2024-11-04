part of '../collection_viewer.dart';

class _ListItem extends StatelessWidget {
  final bool isSelecting;
  final BookData bookData;

  const _ListItem({
    super.key,
    required this.bookData,
    this.isSelecting = false,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);
    if (isSelecting) {
      return BlocBuilder<_Cubit, _State>(
        key: key,
        buildWhen: (previous, current) =>
            previous.selectedSet.contains(bookData) !=
            current.selectedSet.contains(bookData),
        builder: (context, state) {
          return CommonListSelectableListTile(
            isSelecting: isSelecting,
            isSelected: state.selectedSet.contains(bookData),
            onChanged: (value) {
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
        trailing: const Icon(Icons.drag_handle_rounded),
      );
    }
  }
}
