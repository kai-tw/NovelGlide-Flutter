import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/reader_cubit.dart';
import '../../bloc/reader_state.dart';
import '../../settings/reader_bottom_sheet.dart';

class ReaderNavSettingsButton extends StatelessWidget {
  const ReaderNavSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final cubit = BlocProvider.of<ReaderCubit>(context);
        return IconButton(
          icon: Icon(
            Icons.settings_rounded,
            semanticLabel:
                AppLocalizations.of(context)!.accessibilityReaderSettingsButton,
          ),
          onPressed: state.code.isLoaded
              ? () => _navigateToSettingsPage(context, cubit)
              : null,
        );
      },
    );
  }

  void _navigateToSettingsPage(BuildContext context, ReaderCubit cubit) {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1.0,
      showDragHandle: true,
      barrierColor:
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: cubit,
          child: const ReaderBottomSheet(),
        );
      },
    );
  }
}
