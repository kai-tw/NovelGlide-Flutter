part of '../../reset_service.dart';

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

          // Delete all books
          SettingsPageListTile(
            onAccept: sl<BookResetUseCase>(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBooks,
          ),

          // Delete all collections
          SettingsPageListTile(
            onAccept: sl<ResetCollectionSystemUseCase>(),
            onComplete: BlocProvider.of<CollectionListCubit>(context).refresh,
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllCollections,
          ),

          // Delete all bookmarks
          SettingsPageListTile(
            onAccept: () async => BookmarkService.repository.reset(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageDeleteAllBookmarks,
          ),
        ],
      ),
    );
  }
}
