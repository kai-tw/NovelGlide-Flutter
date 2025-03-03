part of 'search_scaffold.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.ttsState != current.ttsState,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded && state.ttsState.isStopped;
        return IconButton(
          icon: const Icon(Icons.search),
          tooltip: appLocalizations.readerSearch,
          onPressed: isEnabled ? () => _onPressed(context) : null,
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    Navigator.of(context).push(
      RouteUtils.pushRoute(
        BlocProvider.value(
          value: cubit.searchCubit,
          child: const SearchScaffold(),
        ),
      ),
    );
  }
}
