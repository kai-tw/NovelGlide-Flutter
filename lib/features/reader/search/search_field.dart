part of 'search_scaffold.dart';

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final SearchCubit cubit = context.read<SearchCubit>();
    return BlocBuilder<SearchCubit, _SearchState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            labelText: AppLocalizations.of(context)!.readerSearch,
          ),
          onChanged: (value) => cubit.setQuery(value),
          initialValue: state.query,
          readOnly: state.code == LoadingStateCode.loading,
        );
      },
    );
  }
}
