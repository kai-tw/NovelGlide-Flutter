part of '../../reset_service.dart';

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
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          // Clear cache (Currently only for Reader)
          SettingsPageListTile(
            onAccept: sl<ReaderClearLocationCacheUseCase>(),
            iconData: Icons.delete_forever_rounded,
            title: appLocalizations.resetPageCacheClear,
            isDangerous: false,
          ),
        ],
      ),
    );
  }
}
