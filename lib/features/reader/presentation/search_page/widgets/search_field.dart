part of '../search_scaffold.dart';

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final ReaderSearchCubit cubit = context.read<ReaderSearchCubit>();
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      buildWhen: (ReaderSearchState previous, ReaderSearchState current) =>
          previous.code != current.code,
      builder: (BuildContext context, ReaderSearchState state) {
        return TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            labelText: AppLocalizations.of(context)!.readerSearch,
          ),
          onChanged: (String value) => cubit.setQuery(value),
          initialValue: state.query,
          readOnly: state.code == LoadingStateCode.loading,
        );
      },
    );
  }
}
