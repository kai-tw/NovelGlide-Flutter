import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_search_cubit.dart';
import 'reader_search_field.dart';
import 'reader_search_range_selector.dart';
import 'reader_search_result_list.dart';
import 'reader_search_submit_btn.dart';

class ReaderSearch extends StatelessWidget {
  const ReaderSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocProvider(
      create: (context) => ReaderSearchCubit(cubit)..init(),
      child: const _ReaderSearch(),
    );
  }
}

class _ReaderSearch extends StatelessWidget {
  const _ReaderSearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(
            child: ReaderSearchResultList(),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: const Column(
              children: [
                ReaderSearchRangeSelector(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 24.0, 0.0, 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ReaderSearchField(),
                      ),
                      ReaderSearchSubmitBtn(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
