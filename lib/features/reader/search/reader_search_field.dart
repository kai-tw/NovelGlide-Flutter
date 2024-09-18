import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_search_cubit.dart';

class ReaderSearchField extends StatelessWidget {
  const ReaderSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSearchCubit cubit = context.read<ReaderSearchCubit>();
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            labelText: AppLocalizations.of(context)!.readerSearch,
          ),
          onChanged: (value) => cubit.searchQuery = value,
          readOnly: state.code == ReaderSearchStateCode.loading,
        );
      },
    );
  }
}