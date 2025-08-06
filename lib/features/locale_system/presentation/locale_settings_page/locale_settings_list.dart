part of '../../locale_utils.dart';

class LocaleSettingsList extends StatelessWidget {
  const LocaleSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (AppState previous, AppState current) =>
          previous.userLocale != current.userLocale,
      builder: (BuildContext context, AppState state) {
        final List<AppLocale?> localeList =
            List<AppLocale?>.from(LocaleUtils.supportedLocales);

        // Use system settings.
        localeList.insert(0, null);

        return ListView.builder(
          itemCount: localeList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildListTile(
              context: context,
              locale: localeList[index],
              isSelected: state.userLocale == localeList[index],
            );
          },
        );
      },
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required AppLocale? locale,
    required bool isSelected,
  }) {
    final AppCubit cubit = BlocProvider.of<AppCubit>(context);
    return ListTile(
      onTap: isSelected ? null : () => cubit.changeLocale(locale),
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
    required AppLocale? locale,
  }) {
    return locale == null
        ? Text(AppLocalizations.of(context)!.useSystemSettings)
        : Localizations.override(
            context: context,
            locale: LocaleUtils.convertAppLocaleToLocale(locale),
            child: Builder(
              builder: (BuildContext context) => Text(
                LocaleUtils.languageNameOf(context, locale),
              ),
            ),
          );
  }

  Widget? _buildSubtitle({
    required BuildContext context,
    required AppLocale? locale,
  }) {
    return locale == null
        ? null
        : Text(
            LocaleUtils.languageNameOf(context, locale),
          );
  }
}
