part of '../../locale_services.dart';

class LocaleSettingsPage extends StatelessWidget {
  const LocaleSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.languageSettings),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: BlocProvider<LocaleSettingsCubit>(
            create: (_) => LocaleSettingsCubit(),
            child: const LocaleSettingsList(),
          ),
        ),
      ),
    );
  }
}
