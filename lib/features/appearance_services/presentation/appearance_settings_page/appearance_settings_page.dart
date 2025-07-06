part of '../../appearance_services.dart';

class AppearanceSettingsPage extends StatelessWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.appearance),
      ),
      body: const SafeArea(
        child: Scrollbar(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: AppearanceSettingsDarkModeCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
