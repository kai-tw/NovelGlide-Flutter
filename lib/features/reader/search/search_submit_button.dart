part of 'search_scaffold.dart';

class _SearchSubmitButton extends StatelessWidget {
  const _SearchSubmitButton();

  @override
  Widget build(BuildContext context) {
    final ReaderSearchCubit cubit = BlocProvider.of<ReaderSearchCubit>(context);
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      buildWhen: (ReaderSearchState previous, ReaderSearchState current) =>
          previous.code != current.code ||
          previous.query.isEmpty != current.query.isEmpty,
      builder: (BuildContext context, ReaderSearchState state) {
        final bool isLoading = state.code == LoadingStateCode.loading;
        final bool isDisabled = isLoading || state.query.isEmpty;
        final ColorScheme colorScheme = Theme.of(context).colorScheme;
        return IconButton(
          onPressed: isDisabled ? null : () => cubit.startSearch(),
          style: IconButton.styleFrom(
            backgroundColor: isDisabled ? null : colorScheme.primary,
            foregroundColor: isDisabled ? null : colorScheme.onPrimary,
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
