import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/features/reader/bloc/reader_state.dart';

import '../../reader/bloc/reader_cubit.dart';

class ReaderSettingsAutoSaveSwitch extends StatelessWidget {
  const ReaderSettingsAutoSaveSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        return Row(
          children: [
            Expanded(
              child: Text(AppLocalizations.of(context)!.readerSettingsAutoSaveSwitch),
            ),
            Switch(
              value: state.readerSettings.autoSave,
              onChanged: (bool value) {
                if (value) {
                  readerCubit.saveBookmark();
                }
                readerCubit.saveSettings(autoSave: value);
              },
            ),
          ],
        );
      },
    );
  }
}
