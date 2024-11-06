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
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CommonDeleteDialog(
                  title: appLocalizations.resetPageDeleteAllBooks,
                  onDelete: () => BookRepository.reset(),
                ),
              );
            },
            leading: const Icon(Icons.delete_forever_rounded),
            title: Text(appLocalizations.resetPageDeleteAllBooks),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CommonDeleteDialog(
                  title: appLocalizations.resetPageDeleteAllCollections,
                  onDelete: () => CollectionRepository.reset(),
                ),
              );
            },
            leading: const Icon(Icons.delete_forever_rounded),
            title: Text(appLocalizations.resetPageDeleteAllCollections),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CommonDeleteDialog(
                  title: appLocalizations.resetPageDeleteAllBookmarks,
                  onDelete: () => BookmarkRepository.reset(),
                ),
              );
            },
            leading: const Icon(Icons.delete_forever_rounded),
            title: Text(appLocalizations.resetPageDeleteAllBookmarks),
          ),
        ],
      ),
    );
  }
}
