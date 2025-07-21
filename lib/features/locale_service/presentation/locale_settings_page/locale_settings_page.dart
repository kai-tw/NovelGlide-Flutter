part of '../../locale_services.dart';

class LocaleSettingsPage extends StatelessWidget {
  const LocaleSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.generalLanguages),
      ),
      body: const SafeArea(
        child: Scrollbar(
          child: LocaleSettingsList(),
        ),
      ),
    );
  }
}
