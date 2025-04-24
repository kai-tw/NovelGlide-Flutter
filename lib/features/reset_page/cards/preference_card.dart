part of '../reset_page.dart';

class _PreferenceCard extends StatelessWidget {
  const _PreferenceCard();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SettingsCard(
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 12.0),
            child: Text(
              appLocalizations.resetPagePreferenceTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _ListTile(
            onDelete: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.bookshelf.sortOrder);
              prefs.remove(PreferenceKeys.bookshelf.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookshelf,
            deleteLabel: appLocalizations.generalReset,
          ),
          _ListTile(
            onDelete: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.collection.sortOrder);
              prefs.remove(PreferenceKeys.collection.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetCollectionList,
            deleteLabel: appLocalizations.generalReset,
          ),
          _ListTile(
            onDelete: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.bookmark.sortOrder);
              prefs.remove(PreferenceKeys.bookmark.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookmarkList,
            deleteLabel: appLocalizations.generalReset,
          ),
          _ListTile(
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
