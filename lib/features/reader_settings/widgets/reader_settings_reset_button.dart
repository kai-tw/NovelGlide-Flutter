import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../../../enum/common_button_state_code.dart';
import '../../reader/bloc/reader_cubit.dart';

class ReaderSettingsResetButton extends StatefulWidget {
  const ReaderSettingsResetButton({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReaderSettingsResetButton> {
  CommonButtonStateCode _state = CommonButtonStateCode.idle;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    IconData iconData;
    Color backgroundColor;
    Color foregroundColor;
    String text;
    void Function()? onPressed;

    switch (_state) {
      case CommonButtonStateCode.idle:
        iconData = Icons.refresh_rounded;
        backgroundColor = Theme.of(context).colorScheme.error;
        foregroundColor = Theme.of(context).colorScheme.onError;
        text = appLocalizations.readerSettingsResetButton;
        onPressed = () => _onPressed(context);
        break;

      case CommonButtonStateCode.success:
        iconData = Icons.refresh_rounded;
        backgroundColor = Colors.green;
        foregroundColor = Colors.white;
        text = appLocalizations.readerSettingsResetButtonDone;
        break;

      default:
        iconData = Icons.refresh_rounded;
        backgroundColor = Theme.of(context).colorScheme.error;
        foregroundColor = Theme.of(context).colorScheme.onError;
        text = appLocalizations.readerSettingsResetButton;
        break;
    }

    return Align(
      alignment: Alignment.centerRight,
      child: FilledButton.tonalIcon(
        icon: Icon(iconData),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: foregroundColor,
        ),
        onPressed: onPressed,
      ),
    );
  }

  void _onPressed(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.alertDialogResetSettingsTitle),
        content: Text(AppLocalizations.of(context)!.alertDialogResetSettingsDescription),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              cubit.setSettings(const ReaderSettingsData()..save());

              setState(() => _state = CommonButtonStateCode.success);
              await Future.delayed(const Duration(seconds: 2));
              setState(() => _state = CommonButtonStateCode.idle);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(AppLocalizations.of(context)!.generalYes),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.generalNo),
          ),
        ],
      ),
    );
  }
}
