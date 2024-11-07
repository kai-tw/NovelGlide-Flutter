part of '../reset_page.dart';

class _DeleteCard extends StatelessWidget {
  const _DeleteCard();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 24.0,
      ),
      child: Column(
        children: [
          _ListTile(
            onDelete: () async => BookRepository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBooks,
          ),
          _ListTile(
            onDelete: () async => CollectionRepository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllCollections,
          ),
          _ListTile(
            onDelete: () async => BookmarkRepository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBookmarks,
          ),
        ],
      ),
    );
  }
}
