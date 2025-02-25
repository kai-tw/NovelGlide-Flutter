part of '../table_of_contents.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final BookData bookData;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBar({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return AppBar(
      leading: const CommonBackButton(),
      title: Text(
        bookData.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              RouteUtils.pushRoute(
                CollectionAddBookScaffold(dataSet: {bookData}),
              ),
            );
          },
          icon: Icon(
            Icons.collections_bookmark_outlined,
            semanticLabel: appLocalizations.collectionTitle,
          ),
        ),
      ],
    );
  }
}
