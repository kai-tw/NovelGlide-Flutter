part of '../../locale_services.dart';

class LocaleSettingsList extends StatelessWidget {
  const LocaleSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppGlobalCubit, AppGlobalState>(
      buildWhen: (AppGlobalState previous, AppGlobalState current) => previous.locale != current.locale,
      builder: (BuildContext context, AppGlobalState state) {
        final List<Locale?> localeList = List<Locale?>.from(LocaleServices.supportedLocales);

        // Use system settings.
        localeList.insert(0, null);

        return ListView.builder(
          itemCount: localeList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildListTile(
              context: context,
              locale: localeList[index],
              isSelected: state.locale == localeList[index],
            );
          },
        );
      },
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required Locale? locale,
    required bool isSelected,
  }) {
    return ListTile(
      onTap: isSelected ? null : () => LocaleServices.userLocale = locale,
      title: _buildTitle(
        context: context,
        locale: locale,
      ),
      subtitle: _buildSubtitle(
        context: context,
        locale: locale,
      ),
      trailing: isSelected ? const Icon(Icons.check_rounded) : null,
    );
  }

  Widget _buildTitle({
    required BuildContext context,
    required Locale? locale,
  }) {
    return locale == null
        ? Text(AppLocalizations.of(context)!.useSystemSettings)
        : Localizations.override(
            context: context,
            locale: locale,
            child: Builder(
              builder: (BuildContext context) => Text(
                LocaleServices.languageNameOf(context, locale),
              ),
            ),
          );
  }

  Widget? _buildSubtitle({
    required BuildContext context,
    required Locale? locale,
  }) {
    return locale == null
        ? null
        : Text(
            LocaleServices.languageNameOf(context, locale),
          );
  }
}
