import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../bloc/reader_settings_bloc.dart';

class ReaderSettingsAutoSaveSwitch extends StatelessWidget {
  const ReaderSettingsAutoSaveSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSettingsCubit cubit = BlocProvider.of<ReaderSettingsCubit>(context);
    return BlocBuilder<ReaderSettingsCubit, ReaderSettingsData>(
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(AppLocalizations.of(context)!.readerSettingsAutoSaveSwitch),
          value: state.autoSave,
          onChanged: (bool value) {
            cubit.setState(autoSave: value);
            cubit.save();
          },
        );
      },
    );
  }
}
