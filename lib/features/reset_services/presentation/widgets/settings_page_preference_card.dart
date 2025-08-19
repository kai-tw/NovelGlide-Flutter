part of '../../reset_service.dart';

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
            onAccept: sl<BookshelfResetPreferenceUseCase>(),
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookshelf,
            deleteLabel: appLocalizations.generalReset,
          ),
          SettingsPageListTile(
            onAccept: sl<CollectionListResetPreferenceUseCase>(),
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetCollectionList,
            deleteLabel: appLocalizations.generalReset,
          ),
          SettingsPageListTile(
            onAccept: sl<BookmarkListResetPreferenceUseCase>(),
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetBookmarkList,
            deleteLabel: appLocalizations.generalReset,
          ),
          SettingsPageListTile(
            onAccept: sl<ReaderResetPreferenceUseCase>(),
            iconData: Icons.refresh_rounded,
            title: appLocalizations.resetPageResetReader,
            deleteLabel: appLocalizations.generalReset,
          ),
        ],
      ),
    );
  }
}
