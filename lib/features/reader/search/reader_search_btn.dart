import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderSearchBtn extends StatelessWidget {
  const ReaderSearchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final bool isDisabled = state.code != ReaderStateCode.loaded && state.code != ReaderStateCode.search;
        final bool isSearching = state.code == ReaderStateCode.search;
        return IconButton(
          icon: Icon(
            isSearching ? Icons.close : Icons.search,
            semanticLabel: AppLocalizations.of(context)!.readerSearch,
          ),
          onPressed: isDisabled ? null : () {
            if (isSearching) {
              cubit.closeSearch();
            } else {
              cubit.openSearch();
            }
          },
        );
      },
    );
  }
}