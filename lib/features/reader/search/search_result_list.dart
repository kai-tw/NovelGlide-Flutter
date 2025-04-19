part of 'search_scaffold.dart';

class _SearchResultList extends StatelessWidget {
  const _SearchResultList();

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
              return Column(
                children: [
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
    final cubit = BlocProvider.of<ReaderSearchCubit>(context);
    final state = cubit.state;

    final query = state.query;
    final result = state.resultList[index];
    final excerpt = result.excerpt.replaceAll(RegExp(r'\s+'), ' ');

    // Highlight the keyword
    final children = <InlineSpan>[];
    String excerptPart = excerpt;
    while (excerptPart.contains(RegExp(query, caseSensitive: false))) {
      final keywordIndex =
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
        cubit.webViewHandler.goto(result.cfi);
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
