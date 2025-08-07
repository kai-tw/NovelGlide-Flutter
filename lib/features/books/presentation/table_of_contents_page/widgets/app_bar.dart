part of '../table_of_contents.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.bookData});

  final Book bookData;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AppBar(
      title: Text(
        bookData.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    CollectionAddBookScaffold(dataSet: <Book>{bookData}),
              ),
            );
          },
          icon: const Icon(Icons.collections_bookmark_outlined),
          tooltip: appLocalizations.generalCollection(2),
        ),
      ],
    );
  }
}
