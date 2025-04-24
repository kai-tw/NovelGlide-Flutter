part of '../reset_page.dart';

class _CacheCard extends StatelessWidget {
  const _CacheCard();

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
              appLocalizations.resetPageCacheTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _ListTile(
            onDelete: () async => CacheRepository.clear(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageCacheClear,
            isDangerous: false,
          ),
        ],
      ),
    );
  }
}
