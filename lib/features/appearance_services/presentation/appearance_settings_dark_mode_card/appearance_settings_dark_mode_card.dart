part of '../../appearance_services.dart';

class AppearanceSettingsDarkModeCard extends StatelessWidget {
  const AppearanceSettingsDarkModeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: BlocProvider<AppearanceSettingsDarkModeCardCubit>(
        create: (_) => AppearanceSettingsDarkModeCardCubit(),
        child: BlocBuilder<AppearanceSettingsDarkModeCardCubit, AppearanceSettingsDarkModeCardState>(
          buildWhen: (AppearanceSettingsDarkModeCardState previous, AppearanceSettingsDarkModeCardState current) =>
              previous.isDarkMode != current.isDarkMode,
          builder: _buildList,
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, AppearanceSettingsDarkModeCardState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final AppearanceSettingsDarkModeCardCubit cubit = BlocProvider.of<AppearanceSettingsDarkModeCardCubit>(context);

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
          trailing: state.isDarkMode == null ? const Icon(Icons.check) : null,
          onTap: state.isDarkMode == null ? null : () => cubit.setDarkMode(null),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.light_mode_rounded),
          title: Text(appLocalizations.lightMode),
          trailing: state.isDarkMode == false ? const Icon(Icons.check) : null,
          onTap: state.isDarkMode == false ? null : () => cubit.setDarkMode(false),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.dark_mode_rounded),
          title: Text(appLocalizations.darkMode),
          trailing: state.isDarkMode == true ? const Icon(Icons.check) : null,
          onTap: state.isDarkMode == true ? null : () => cubit.setDarkMode(true),
        ),
      ],
    );
  }
}
