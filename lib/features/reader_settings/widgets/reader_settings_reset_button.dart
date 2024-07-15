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

    return Align(
      alignment: Alignment.centerRight,
      child: BlocProvider(
        create: (_) => ReaderSettingsResetButtonCubit(
          defaultBackgroundColor: Theme.of(context).colorScheme.error,
          defaultForegroundColor: Theme.of(context).colorScheme.onError,
          defaultText: appLocalizations.readerSettingsResetButton,
          doneText: appLocalizations.readerSettingsResetButtonDone,
        ),
        child: BlocBuilder<ReaderSettingsResetButtonCubit, ReaderSettingsResetButtonState>(
          builder: (context, state) {
            return FilledButton.tonalIcon(
              icon: Icon(state.iconData),
              label: Text(state.text),
              style: OutlinedButton.styleFrom(
                backgroundColor: state.backgroundColor,
                foregroundColor: state.foregroundColor,
                disabledBackgroundColor: state.backgroundColor,
                disabledForegroundColor: state.foregroundColor,
              ),
              onPressed: state.isDisabled ? null : () => _onPressed(context),
            );
          },
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    final ReaderSettingsResetButtonCubit buttonCubit = BlocProvider.of<ReaderSettingsResetButtonCubit>(context);
    final ReaderSettingsCubit settingsCubit = BlocProvider.of<ReaderSettingsCubit>(context);
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.alertDialogResetSettingsTitle),
        content: Text(AppLocalizations.of(context)!.alertDialogResetSettingsDescription),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              buttonCubit.onPressedHandler();
              settingsCubit.reset();
              readerCubit.resetSettings();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(AppLocalizations.of(context)!.yes),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.no),
          ),
        ],
      ),
    );
  }
}
