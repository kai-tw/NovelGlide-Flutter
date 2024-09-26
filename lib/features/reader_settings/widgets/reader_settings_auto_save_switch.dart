import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../reader/bloc/reader_cubit.dart';
import '../../reader/bloc/reader_state.dart';

class ReaderSettingsAutoSaveSwitch extends StatelessWidget {
  const ReaderSettingsAutoSaveSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.readerSettings.autoSave != current.readerSettings.autoSave,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(AppLocalizations.of(context)!.readerSettingsAutoSaveSwitch),
          value: state.readerSettings.autoSave,
          onChanged: (bool value) {
            cubit.setSettings(state.readerSettings.copyWith(autoSave: value)..save());
          },
        );
      },
    );
  }
}
