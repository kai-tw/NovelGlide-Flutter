part of '../reset_service.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.resetPageTitle),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SettingsPagePreferenceCard(),
              SettingsPageCacheCard(),
              SettingsPageDataCard(),
            ],
          ),
        ),
      ),
    );
  }
}
