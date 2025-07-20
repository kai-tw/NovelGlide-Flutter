part of '../search_scaffold.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code || previous.ttsState != current.ttsState,
      builder: (BuildContext context, ReaderState state) {
        final bool isEnabled = state.code.isLoaded && state.ttsState.isStopped;
        return IconButton(
          icon: const Icon(Icons.search),
          tooltip: appLocalizations.readerSearch,
          onPressed: isEnabled ? () => _onPressed(context) : null,
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<ReaderSearchCubit>.value(
          value: cubit.searchCubit,
          child: const SearchScaffold(),
        ),
      ),
    );
  }
}
