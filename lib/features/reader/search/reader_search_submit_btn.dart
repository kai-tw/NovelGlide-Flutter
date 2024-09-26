import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/loading_state_code.dart';
import '../bloc/reader_search_cubit.dart';

class ReaderSearchSubmitBtn extends StatelessWidget {
  const ReaderSearchSubmitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSearchCubit cubit = context.read<ReaderSearchCubit>();
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      buildWhen: (previous, current) => previous.code != current.code || previous.query != current.query,
      builder: (context, state) {
        final bool isDisabled = state.code == LoadingStateCode.loading || state.query.isEmpty;
        return IconButton(
          onPressed: isDisabled ? null : () => cubit.startSearch(),
          style: IconButton.styleFrom(
            backgroundColor: isDisabled ? null : Theme.of(context).colorScheme.primary,
            foregroundColor: isDisabled ? null : Theme.of(context).colorScheme.onPrimary,
          ),
          icon: Icon(
            Icons.search,
            semanticLabel: AppLocalizations.of(context)!.readerSearch,
          ),
        );
      },
    );
  }
}
