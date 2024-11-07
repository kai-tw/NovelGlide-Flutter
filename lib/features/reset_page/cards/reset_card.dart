part of '../reset_page.dart';

class _ResetCard extends StatelessWidget {
  const _ResetCard();

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
            onDelete: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.bookshelf.sortOrder);
              prefs.remove(PreferenceKeys.bookshelf.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookshelf,
            deleteLabel: appLocalizations.generalReset,
          ),
          _ListTile(
            onDelete: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.collection.sortOrder);
              prefs.remove(PreferenceKeys.collection.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetCollectionList,
            deleteLabel: appLocalizations.generalReset,
          ),
          _ListTile(
            onDelete: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.bookmark.sortOrder);
              prefs.remove(PreferenceKeys.bookmark.isAscending);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookmarkList,
            deleteLabel: appLocalizations.generalReset,
          ),
          _ListTile(
            onDelete: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove(PreferenceKeys.reader.autoSave);
              prefs.remove(PreferenceKeys.reader.fontSize);
              prefs.remove(PreferenceKeys.reader.gestureDetection);
              prefs.remove(PreferenceKeys.reader.lineHeight);
            },
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetReader,
            deleteLabel: appLocalizations.generalReset,
          ),
          ThemeSwitcher.switcher(builder: (_, switcher) {
            return _ListTile(
              onDelete: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove(PreferenceKeys.theme.themeId);
                prefs.remove(PreferenceKeys.theme.brightness);

                final record = await ThemeDataRecord.currentTheme;
                switcher.changeTheme(theme: record);
              },
              iconData: Icons.refresh_rounded,
              title: appLocalizations.resetPageResetThemeManager,
              deleteLabel: appLocalizations.generalReset,
            );
          }),
          ThemeSwitcher.switcher(builder: (context, switcher) {
            return _ListTile(
              onDelete: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();

                final record = await ThemeDataRecord.currentTheme;
                switcher.changeTheme(theme: record);
              },
              iconData: Icons.refresh_rounded,
              title: appLocalizations.resetPageResetPreference,
              deleteLabel: appLocalizations.generalReset,
            );
          }),
        ],
      ),
    );
  }
}
