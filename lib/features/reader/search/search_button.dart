part of '../reader.dart';

class _SearchButton extends StatelessWidget {
  const _SearchButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final isDisabled = state.code != LoadingStateCode.loaded;
        return IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: AppLocalizations.of(context)!.readerSearch,
          ),
          onPressed: isDisabled ? null : () => _onPressed(context),
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final cubit = BlocProvider.of<_ReaderCubit>(context);
    Navigator.of(context).push(
      RouteUtils.pushRoute(
        BlocProvider.value(
          value: cubit._searchCubit,
          child: const _SearchScaffold(),
        ),
      ),
    );
  }
}
