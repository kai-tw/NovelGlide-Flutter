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
      create: (context) => ReaderSearchCubit(readerCubit: cubit),
      child: const _ReaderSearch(),
    );
  }
}

class _ReaderSearch extends StatelessWidget {
  const _ReaderSearch();

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    readerCubit.searchCubit = BlocProvider.of<ReaderSearchCubit>(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ReaderSearchResultList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ReaderSearchRangeSelector(),
          ),
          Row(
            children: [
              Expanded(
                child: ReaderSearchField(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ReaderSearchSubmitBtn(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
