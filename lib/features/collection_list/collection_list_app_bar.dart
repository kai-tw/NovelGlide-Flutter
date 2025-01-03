part of 'collection_list.dart';

class CollectionListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CollectionListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    return AppBar(
      leading: const Icon(Icons.collections_bookmark_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(AppLocalizations.of(context)!.collectionTitle),
      actions: const [
        CommonListSelectAllButton<CollectionListCubit, CollectionData>(),
        CommonListDoneButton<CollectionListCubit, CollectionData>(),
        _PopupMenuButton(),
      ],
    );
  }
}
