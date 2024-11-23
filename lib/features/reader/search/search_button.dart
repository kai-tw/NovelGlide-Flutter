part of 'search_scaffold.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: AppLocalizations.of(context)!.readerSearch,
          ),
          onPressed: !state.code.isLoaded ? null : () => _onPressed(context),
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
