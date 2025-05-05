part of '../reset_page.dart';

class SettingsPageDataCard extends StatelessWidget {
  const SettingsPageDataCard();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              appLocalizations.resetPageDataTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SettingsPageListTile(
            onDelete: () async => CollectionRepository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllCollections,
          ),
          SettingsPageListTile(
            onDelete: () async => BookmarkRepository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBookmarks,
          ),
          SettingsPageListTile(
            onDelete: () async => BookRepository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBooks,
          ),
        ],
      ),
    );
  }
}
