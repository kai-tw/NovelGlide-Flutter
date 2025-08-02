import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/cubit/app_cubit.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../settings_page/settings_service.dart';
import '../../domain/entities/appearance_settings.dart';

class AppearanceSettingsDarkModeCard extends StatelessWidget {
  const AppearanceSettingsDarkModeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (AppState previous, AppState current) =>
            previous.themeMode != current.themeMode,
        builder: _buildList,
      ),
    );
  }

  Widget _buildList(BuildContext context, AppState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final AppCubit cubit = BlocProvider.of<AppCubit>(context);

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
          trailing: state.themeMode == AppThemeMode.system
              ? const Icon(Icons.check)
              : null,
          onTap: state.themeMode == AppThemeMode.system
              ? null
              : () => cubit.changeThemeMode(AppThemeMode.system),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.light_mode_rounded),
          title: Text(appLocalizations.lightMode),
          trailing: state.themeMode == AppThemeMode.light
              ? const Icon(Icons.check)
              : null,
          onTap: state.themeMode == AppThemeMode.light
              ? null
              : () => cubit.changeThemeMode(AppThemeMode.light),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.dark_mode_rounded),
          title: Text(appLocalizations.darkMode),
          trailing: state.themeMode == AppThemeMode.dark
              ? const Icon(Icons.check)
              : null,
          onTap: state.themeMode == AppThemeMode.dark
              ? null
              : () => cubit.changeThemeMode(AppThemeMode.dark),
        ),
      ],
    );
  }
}
