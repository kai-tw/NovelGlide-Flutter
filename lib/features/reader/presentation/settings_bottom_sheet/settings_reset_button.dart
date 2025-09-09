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
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    IconData iconData = Icons.refresh_rounded;
    Color backgroundColor = Theme.of(context).colorScheme.error;
    Color foregroundColor = Theme.of(context).colorScheme.onError;
    String text = appLocalizations.readerResetSettings;

    if (_stateCode.isSuccess) {
      iconData = Icons.check_rounded;
      backgroundColor = Colors.green;
      foregroundColor = Colors.white;
      text = appLocalizations.readerResetDone;
    }

    return FilledButton.icon(
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
      onPressed: _stateCode.isIdle ? _onPressed : null,
    );
  }

  void _onPressed() {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    _showAlertDialog(onConfirm: () async {
      await cubit.resetPreference();

      setState(() => _stateCode = CommonButtonStateCode.success);
      await Future<void>.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _stateCode = CommonButtonStateCode.idle);
      }
    });
  }

  /// Shows an alert dialog to confirm the reset operation.
  void _showAlertDialog({void Function()? onConfirm}) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(appLocalizations.alertDialogResetSettingsTitle),
        content: Text(appLocalizations.alertDialogResetSettingsDescription),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm?.call();
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
