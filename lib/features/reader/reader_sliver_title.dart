import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';

class ReaderSliverTitle extends StatelessWidget {
  const ReaderSliverTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ReaderCubit, ReaderState>(
        buildWhen: (previous, current) => previous.chapterNumber != current.chapterNumber,
        builder: (BuildContext context, ReaderState state) {
          return Text(
            AppLocalizations.of(context)!.chapterLabel(state.chapterNumber),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }
}
