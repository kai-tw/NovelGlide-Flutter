import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/loading_state_code.dart';
import '../../common_components/common_loading.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_search_cubit.dart';

class ReaderSearchResultList extends StatelessWidget {
  const ReaderSearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.resultList != current.resultList,
      builder: (context, state) {
        final resultList = state.resultList;

        switch (state.code) {
          case LoadingStateCode.initial:
            return Center(
              child: Text(appLocalizations.readerSearchTypeToSearch),
            );

          case LoadingStateCode.loading:
            return const Center(child: CommonLoading());

          case LoadingStateCode.loaded:
            if (resultList.isEmpty) {
              return Center(
                child: Text(appLocalizations.readerSearchNoResult),
              );
            } else {
              return Scrollbar(
                child: ListView.builder(
                  itemBuilder: _itemBuilder,
                  itemCount: resultList.length,
                ),
              );
            }
        }
      },
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final readerCubit = BlocProvider.of<ReaderCubit>(context);
    final state = BlocProvider.of<ReaderSearchCubit>(context).state;

    final query = state.query;
    final result = state.resultList[index];
    final excerpt = result.excerpt.replaceAll(RegExp(r'\s+'), ' ');

    // Highlight the keyword
    final keywordIndex = excerpt.indexOf(RegExp(query, caseSensitive: false));
    final prefix = excerpt.substring(0, keywordIndex);
    final target = excerpt.substring(keywordIndex, keywordIndex + query.length);
    final suffix = excerpt.substring(keywordIndex + query.length);

    return ListTile(
      onTap: () {
        readerCubit.goto(result.cfi);
        readerCubit.closeSearch();
      },
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: prefix),
            TextSpan(
                text: target,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(text: suffix),
          ],
        ),
      ),
    );
  }
}
