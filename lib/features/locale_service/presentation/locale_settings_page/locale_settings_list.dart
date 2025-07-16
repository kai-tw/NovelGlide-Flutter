part of '../../locale_services.dart';

class LocaleSettingsList extends StatelessWidget {
  const LocaleSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleSettingsCubit cubit =
        BlocProvider.of<LocaleSettingsCubit>(context);

    return BlocBuilder<LocaleSettingsCubit, LocaleSettingsState>(
      buildWhen: (LocaleSettingsState previous, LocaleSettingsState current) =>
          previous.selectedLocale != current.selectedLocale,
      builder: (BuildContext context, LocaleSettingsState state) {
        return ListView.builder(
          itemCount: LocaleServices.supportedLocales.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              final bool isSelected = state.selectedLocale == null;
              return ListTile(
                onTap:
                    isSelected ? null : () => cubit.selectLocale(context, null),
                title: Text(AppLocalizations.of(context)!.useSystemSettings),
                trailing: isSelected ? const Icon(Icons.check_rounded) : null,
              );
            } else {
              final Locale currentLocale =
                  LocaleServices.supportedLocales[index - 1];
              final bool isSelected = state.selectedLocale == currentLocale;
              return ListTile(
                onTap: isSelected
                    ? null
                    : () => cubit.selectLocale(context, currentLocale),
                title: Localizations.override(
                  context: context,
                  locale: currentLocale,
                  child: Builder(
                    builder: (BuildContext context) => Text(
                      LocaleServices.languageNameOf(
                        context,
                        currentLocale,
                      ),
                    ),
                  ),
                ),
                subtitle: Text(
                  LocaleServices.languageNameOf(
                    context,
                    currentLocale,
                  ),
                ),
                trailing: isSelected ? const Icon(Icons.check_rounded) : null,
              );
            }
          },
        );
      },
    );
  }
}
