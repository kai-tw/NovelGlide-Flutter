part of '../reset_page.dart';

class SettingsPageCacheCard extends StatelessWidget {
  const SettingsPageCacheCard({super.key});

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
              appLocalizations.resetPageCacheTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SettingsPageListTile(
            onDelete: () async => LocationCacheRepository.clear(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageCacheClear,
            isDangerous: false,
          ),
        ],
      ),
    );
  }
}
