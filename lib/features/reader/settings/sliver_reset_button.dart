import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';

class ReaderSettingsSliverResetButton extends StatelessWidget {
  const ReaderSettingsSliverResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerRight,
        child: OutlinedButton.icon(
          icon: const Icon(Icons.restart_alt_rounded),
          label: Text(AppLocalizations.of(context)!.reset_settings),
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 2.0, color: Theme.of(context).colorScheme.primary),
          ),
          onPressed: () => BlocProvider.of<ReaderCubit>(context).resetSettings(),
        ),
      ),
    );
  }
}
