part of '../reader.dart';

class _SearchSubmitButton extends StatelessWidget {
  const _SearchSubmitButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_SearchCubit>(context);
    return BlocBuilder<_SearchCubit, _SearchState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.query.isEmpty != current.query.isEmpty,
      builder: (context, state) {
        final isLoading = state.code == LoadingStateCode.loading;
        final isDisabled = isLoading || state.query.isEmpty;
        final colorScheme = Theme.of(context).colorScheme;
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
