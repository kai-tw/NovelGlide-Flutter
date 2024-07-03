import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../../reader/bloc/reader_cubit.dart';
import '../bloc/reader_settings_bloc.dart';

class ReaderSettingsAutoSaveSwitch extends StatelessWidget {
  const ReaderSettingsAutoSaveSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSettingsCubit cubit = BlocProvider.of<ReaderSettingsCubit>(context);
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return Row(
      children: [
        Expanded(
          child: Text(AppLocalizations.of(context)!.readerSettingsAutoSaveSwitch),
        ),
        BlocBuilder<ReaderSettingsCubit, ReaderSettingsData>(
          builder: (BuildContext context, ReaderSettingsData state) {
            return Switch(
              value: state.autoSave,
              onChanged: (bool value) {
                cubit.setState(autoSave: value);
                readerCubit.setSettings(autoSave: value);
                cubit.save();
              },
            );
          },
        ),
      ],
    );
  }
}
