import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../reader/bloc/reader_cubit.dart';
import '../../reader/bloc/reader_state.dart';

class ReaderSettingsGestureSwitcher extends StatelessWidget {
  const ReaderSettingsGestureSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.gestureDetection !=
          current.readerSettings.gestureDetection,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(appLocalizations.readerSettingsGesture),
          value: state.readerSettings.gestureDetection,
          onChanged: (value) {
            cubit.setSettings(gestureDetection: value);
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
