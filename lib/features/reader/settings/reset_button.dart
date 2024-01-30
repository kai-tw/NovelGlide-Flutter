import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_button_state.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsResetButton extends StatelessWidget {
  const ReaderSettingsResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);

    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerRight,
        child: BlocBuilder<ReaderCubit, ReaderState>(
          builder: (BuildContext context, ReaderState state) {
            IconData iconData = Icons.restart_alt_rounded;
            String text = AppLocalizations.of(context)!.reader_settings_reset_button;
            Color defaultColor = Theme.of(context).colorScheme.error;
            void Function()? onPressed;

            switch (state.buttonState.rstSettingsState) {
              case RdrBtnRstSettingsState.normal:
                onPressed = readerCubit.onClickedRstSettingsBtn;
                break;
              case RdrBtnRstSettingsState.done:
                iconData = Icons.check_rounded;
                text = AppLocalizations.of(context)!.reader_settings_reset_button_done;
                defaultColor = Colors.green;
                break;
              case RdrBtnRstSettingsState.disabled:
                break;
            }

            return OutlinedButton.icon(
              icon: Icon(
                iconData,
                color: defaultColor,
              ),
              label: Text(text, style: TextStyle(color: defaultColor)),
              style: OutlinedButton.styleFrom(
                disabledForegroundColor: defaultColor,
                side: BorderSide(width: 1.0, color: defaultColor),
              ),
              onPressed: onPressed,
            );
          },
        ),
      ),
    );
  }
}
