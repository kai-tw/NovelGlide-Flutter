part of '../reset_page.dart';

class _DataCard extends StatelessWidget {
  const _DataCard();

  /// TODO: Localization

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SettingsCard(
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 12.0),
            child: Text(
              'Data',
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
          _ListTile(
            onDelete: () async => BookRepository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBooks,
          ),
        ],
      ),
    );
  }
}
