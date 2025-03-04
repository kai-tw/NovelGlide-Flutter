part of 'reader_bottom_sheet.dart';

class _SettingsResetButton extends StatefulWidget {
  const _SettingsResetButton();

  @override
  State<_SettingsResetButton> createState() => _SettingsResetButtonState();
}

class _SettingsResetButtonState extends State<_SettingsResetButton> {
  CommonButtonStateCode _stateCode = CommonButtonStateCode.idle;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    IconData iconData = Icons.refresh_rounded;
    Color backgroundColor = Theme.of(context).colorScheme.error;
    Color foregroundColor = Theme.of(context).colorScheme.onError;
    String text = appLocalizations.readerResetSettings;

    if (_stateCode == CommonButtonStateCode.success) {
      iconData = Icons.check_rounded;
      backgroundColor = Colors.green;
      foregroundColor = Colors.white;
      text = appLocalizations.readerResetDone;
    }

    return Align(
      alignment: Alignment.centerRight,
      child: FilledButton.icon(
        icon: Icon(iconData),
        label: Text(text),
        style: FilledButton.styleFrom(
          iconColor: foregroundColor,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledIconColor: foregroundColor,
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
              cubit.resetSettings();
              cubit.saveSettings();

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
