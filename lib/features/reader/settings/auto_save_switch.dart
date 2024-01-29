import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsAutoSaveSwitch extends StatelessWidget {
  const ReaderSettingsAutoSaveSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return SliverToBoxAdapter(
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (BuildContext context, ReaderState state) {
          return Row(
            children: [
              Expanded(
                child: Text(AppLocalizations.of(context)!.reader_settings_auto_save_switch),
              ),
              Switch(
                value: state.readerSettings.autoSave,
                onChanged: (bool value) => readerCubit.saveSettings(autoSave: value),
                inactiveThumbColor: Theme.of(context).colorScheme.primary,
                inactiveTrackColor: Theme.of(context).colorScheme.surface,
                activeColor: Theme.of(context).colorScheme.surface,
                activeTrackColor: Theme.of(context).colorScheme.primary,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashRadius: 0.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
