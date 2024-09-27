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
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      buildWhen: (previous, current) => previous.code != current.code || previous.query != current.query,
      builder: (context, state) {
        final List<ReaderSearchResult> searchResultList = state.searchResultList;
        Widget child;

        switch (state.code) {
          case LoadingStateCode.initial:
            child = Center(child: Text(AppLocalizations.of(context)!.readerSearchTypeToSearch));
            break;

          case LoadingStateCode.loading:
            child = const Center(child: CommonLoading());
            break;

          case LoadingStateCode.loaded:
            if (searchResultList.isEmpty) {
              child = Center(child: Text(AppLocalizations.of(context)!.readerSearchNoResult));
            } else {
              child = Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final ReaderSearchResult result = searchResultList[index];
                    final String excerpt = result.excerpt.replaceAll(RegExp(r'\s+'), ' ');
                    final int keywordIndex = excerpt.indexOf(RegExp(state.query, caseSensitive: false));
                    final String prefix = excerpt.substring(0, keywordIndex);
                    final String target = excerpt.substring(keywordIndex, keywordIndex + state.query.length);
                    final String suffix = excerpt.substring(keywordIndex + state.query.length);
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
                  },
                  itemCount: searchResultList.length,
                ),
              );
            }
        }

        return child;
      },
    );
  }
}
