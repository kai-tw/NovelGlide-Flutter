import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../reader_settings/reader_settings_bottom_sheet.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsButton extends StatelessWidget {
  const ReaderSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
        final isDisabled = state.code != ReaderStateCode.loaded;
        return IconButton(
          icon: Icon(
            Icons.settings_rounded,
            semanticLabel: AppLocalizations.of(context)!.accessibilityReaderSettingsButton,
          ),
          onPressed: isDisabled ? null : () => _navigateToSettingsPage(context, cubit),
        );
      },
    );
  }

  void _navigateToSettingsPage(BuildContext context, ReaderCubit cubit) {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1.0,
      showDragHandle: true,
      barrierColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: cubit,
          child: const ReaderSettingsBottomSheet(),
        );
      },
    );
  }
}