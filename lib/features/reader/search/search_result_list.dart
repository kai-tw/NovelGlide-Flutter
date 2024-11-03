part of '../reader.dart';

class _SearchResultList extends StatelessWidget {
  const _SearchResultList();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_SearchCubit, _SearchState>(
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
    final cubit = BlocProvider.of<_SearchCubit>(context);
    final state = cubit.state;

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
        Navigator.of(context).pop();
        cubit.readerCubit.goto(result.cfi);
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
              ),
            ),
            TextSpan(text: suffix),
          ],
        ),
      ),
    );
  }
}
