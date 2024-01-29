import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsResetButton extends StatelessWidget {
  const ReaderSettingsResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerRight,
        child: BlocBuilder<ReaderCubit, ReaderState>(
          builder: (BuildContext context, ReaderState state) {
            return OutlinedButton.icon(
              icon: const Icon(Icons.restart_alt_rounded),
              label: Text(AppLocalizations.of(context)!.reset_settings),
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 2.0, color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: () => BlocProvider.of<ReaderCubit>(context).resetSettings(),
            );
          },
        ),
      ),
    );
  }
}
