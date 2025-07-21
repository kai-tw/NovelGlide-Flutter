part of '../../appearance_services.dart';

class AppearanceSettingsDarkModeCard extends StatelessWidget {
  const AppearanceSettingsDarkModeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: BlocBuilder<AppGlobalCubit, AppGlobalState>(
        buildWhen: (AppGlobalState previous, AppGlobalState current) => previous.themeMode != current.themeMode,
        builder: _buildList,
      ),
    );
  }

  Widget _buildList(BuildContext context, AppGlobalState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          appLocalizations.darkMode,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.brightness_auto_rounded),
          title: Text(appLocalizations.useSystemSettings),
          trailing: state.themeMode == ThemeMode.system ? const Icon(Icons.check) : null,
          onTap: state.themeMode == ThemeMode.system ? null : () => AppearanceServices.setThemeMode(ThemeMode.system),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.light_mode_rounded),
          title: Text(appLocalizations.lightMode),
          trailing: state.themeMode == ThemeMode.light ? const Icon(Icons.check) : null,
          onTap: state.themeMode == ThemeMode.light ? null : () => AppearanceServices.setThemeMode(ThemeMode.light),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.dark_mode_rounded),
          title: Text(appLocalizations.darkMode),
          trailing: state.themeMode == ThemeMode.dark ? const Icon(Icons.check) : null,
          onTap: state.themeMode == ThemeMode.dark ? null : () => AppearanceServices.setThemeMode(ThemeMode.dark),
        ),
      ],
    );
  }
}
