part of 'collection_list.dart';

class CollectionListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollectionListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      iconData: Icons.collections_bookmark_rounded,
      title: appLocalizations.collectionTitle,
      actions: const <Widget>[
        SharedListSelectAllButton<CollectionListCubit>(),
        SharedListDoneButton<CollectionListCubit>(),
        CollectionListAppBarMoreButton(),
      ],
    );
  }
}
