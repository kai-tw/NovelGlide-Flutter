part of '../search_scaffold.dart';

class _SearchResultList extends StatelessWidget {
  const _SearchResultList();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      buildWhen: (ReaderSearchState previous, ReaderSearchState current) =>
          previous.code != current.code ||
          previous.resultList != current.resultList,
      builder: (BuildContext context, ReaderSearchState state) {
        final List<ReaderSearchResultData> resultList = state.resultList;

        switch (state.code) {
          case LoadingStateCode.initial:
            return Center(
              child: Text(appLocalizations.readerSearchTypeToSearch),
            );

          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            return const Center(child: CommonLoading());

          case LoadingStateCode.loaded:
            if (resultList.isEmpty) {
              return Center(
                child: Text(appLocalizations.readerSearchNoResult),
              );
            } else {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(appLocalizations
                        .readerSearchResultCount(resultList.length)),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemBuilder: _itemBuilder,
                        itemCount: resultList.length,
                      ),
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final ReaderSearchCubit cubit = BlocProvider.of<ReaderSearchCubit>(context);
    final ReaderSearchState state = cubit.state;

    final String query = state.query;
    final ReaderSearchResultData result = state.resultList[index];
    final String excerpt = result.excerpt.replaceAll(RegExp(r'\s+'), ' ');

    // Highlight the keyword
    final List<InlineSpan> children = <InlineSpan>[];
    String excerptPart = excerpt;
    while (excerptPart.contains(RegExp(query, caseSensitive: false))) {
      final int keywordIndex =
          excerptPart.indexOf(RegExp(query, caseSensitive: false));

      // prefix part
      if (keywordIndex > 0) {
        children.add(TextSpan(text: excerptPart.substring(0, keywordIndex)));
      }

      // keyword part
      children.add(TextSpan(
        text: excerptPart.substring(keywordIndex, keywordIndex + query.length),
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontWeight: FontWeight.bold,
        ),
      ));
      excerptPart = excerptPart.substring(keywordIndex + query.length);
    }

    // Remaining part
    if (excerptPart.isNotEmpty) {
      children.add(TextSpan(text: excerptPart));
    }

    return ListTile(
      onTap: () {
        Navigator.of(context).pop();
        cubit.goto(result.cfi);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (_) => _SearchItemOperationDialog(result),
        );
      },
      title: Text.rich(
        TextSpan(
          children: children,
        ),
      ),
    );
  }
}
