import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../reader/bloc/reader_cubit.dart';
import '../bloc/reader_settings_bloc.dart';
import '../bloc/reader_settings_reset_button_bloc.dart';

class ReaderSettingsResetButton extends StatelessWidget {
  const ReaderSettingsResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderSettingsCubit settingsCubit = BlocProvider.of<ReaderSettingsCubit>(context);
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);

    return Align(
      alignment: Alignment.centerRight,
      child: BlocProvider(
        create: (_) => ReaderSettingsResetButtonCubit(
          defaultColor: Theme.of(context).colorScheme.error,
          defaultText: appLocalizations.readerSettingsResetButton,
          doneText: appLocalizations.readerSettingsResetButtonDone,
        ),
        child: BlocBuilder<ReaderSettingsResetButtonCubit, ReaderSettingsResetButtonState>(
          builder: (context, state) {
            return OutlinedButton.icon(
              icon: Icon(
                state.iconData,
                color: state.color,
              ),
              label: Text(state.text, style: TextStyle(color: state.color)),
              style: OutlinedButton.styleFrom(
                disabledForegroundColor: state.color,
                side: BorderSide(width: 1.0, color: state.color),
              ),
              onPressed: state.isDisabled
                  ? null
                  : () {
                      BlocProvider.of<ReaderSettingsResetButtonCubit>(context).onPressedHandler();
                      settingsCubit.reset();
                      readerCubit.resetSettings();
                    },
            );
          },
        ),
      ),
    );
  }
}
