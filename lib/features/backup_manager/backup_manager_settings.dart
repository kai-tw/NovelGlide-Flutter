import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/backup_manager_settings_bloc.dart';

class BackupManagerSettings extends StatelessWidget {
  const BackupManagerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BackupManagerSettingsCubit()..init(),
      child: _BackupManagerSettings(key: key),
    );
  }
}

class _BackupManagerSettings extends StatelessWidget {
  const _BackupManagerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupManagerSettingsCubit cubit = BlocProvider.of<BackupManagerSettingsCubit>(context);
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(24.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: [
          BlocBuilder<BackupManagerSettingsCubit, BackupManagerSettingsState>(
            buildWhen: (previous, current) => previous.isBackupCollections != current.isBackupCollections,
            builder: (context, state) {
              return SwitchListTile(
                title: Text(appLocalizations.backupManagerBackupCollection),
                value: state.isBackupCollections,
                onChanged: (value) => cubit.setState(backupCollections: value),
              );
            },
          ),
          BlocBuilder<BackupManagerSettingsCubit, BackupManagerSettingsState>(
            buildWhen: (previous, current) => previous.isBackupBookmarks != current.isBackupBookmarks,
            builder: (context, state) {
              return SwitchListTile(
                title: Text(appLocalizations.backupManagerBackupBookmark),
                value: state.isBackupBookmarks,
                onChanged: (value) => cubit.setState(backupBookmarks: value),
              );
            },
          ),
        ],
      ),
    );
  }
}