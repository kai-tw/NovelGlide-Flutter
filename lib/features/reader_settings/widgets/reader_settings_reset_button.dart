import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../../../enum/common_button_state_code.dart';
import '../../reader/bloc/reader_cubit.dart';

class ReaderSettingsResetButton extends StatefulWidget {
  const ReaderSettingsResetButton({super.key});

  @override
  State<ReaderSettingsResetButton> createState() => _State();
}

class _State extends State<ReaderSettingsResetButton> {
  CommonButtonStateCode _stateCode = CommonButtonStateCode.idle;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    IconData iconData = Icons.refresh_rounded;
    Color backgroundColor = Theme.of(context).colorScheme.error;
    Color foregroundColor = Theme.of(context).colorScheme.onError;
    String text = appLocalizations.readerSettingsResetButton;

    if (_stateCode == CommonButtonStateCode.success) {
      iconData = Icons.check_rounded;
      backgroundColor = Colors.green;
      foregroundColor = Colors.white;
      text = appLocalizations.readerSettingsResetButtonDone;
    }

    return Align(
      alignment: Alignment.centerRight,
      child: FilledButton.icon(
        icon: Icon(iconData),
        label: Text(text),
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: foregroundColor,
        ),
        onPressed: _stateCode == CommonButtonStateCode.idle ? _onPressed : null,
      ),
    );
  }

  void _onPressed() {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.alertDialogResetSettingsTitle),
        content: Text(appLocalizations.alertDialogResetSettingsDescription),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              cubit.setSettings(const ReaderSettingsData()..save());

              setState(() => _stateCode = CommonButtonStateCode.success);
              await Future.delayed(const Duration(seconds: 2));
              if (mounted) {
                setState(() => _stateCode = CommonButtonStateCode.idle);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(appLocalizations.generalYes),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(appLocalizations.generalNo),
          ),
        ],
      ),
    );
  }
}
