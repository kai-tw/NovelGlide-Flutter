part of '../../reset_page.dart';

class SettingsPagePreferenceCard extends StatelessWidget {
  const SettingsPagePreferenceCard({super.key});

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
              appLocalizations.resetPagePreferenceTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          SettingsPageListTile(
            onDelete: BookService.preference.reset,
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookshelf,
            deleteLabel: appLocalizations.generalReset,
          ),
          SettingsPageListTile(
            onDelete: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.collection.sortOrder);
              prefs.remove(PreferenceKeys.collection.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetCollectionList,
            deleteLabel: appLocalizations.generalReset,
          ),
          SettingsPageListTile(
            onDelete: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.bookmark.sortOrder);
              prefs.remove(PreferenceKeys.bookmark.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookmarkList,
            deleteLabel: appLocalizations.generalReset,
          ),
          SettingsPageListTile(
            onDelete: () async {
              await const ReaderSettingsData().save();
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetReader,
            deleteLabel: appLocalizations.generalReset,
          ),
        ],
      ),
    );
  }
}
