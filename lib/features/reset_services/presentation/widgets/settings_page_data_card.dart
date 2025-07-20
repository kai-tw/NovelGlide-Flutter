part of '../../reset_page.dart';

class SettingsPageDataCard extends StatelessWidget {
  const SettingsPageDataCard({super.key});

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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          SettingsPageListTile(
            onDelete: () async => CollectionService.repository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllCollections,
          ),
          SettingsPageListTile(
            onDelete: () async => BookmarkService.repository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBookmarks,
          ),
          SettingsPageListTile(
            onDelete: () async => BookService.repository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBooks,
          ),
        ],
      ),
    );
  }
}
