part of 'search_scaffold.dart';

class _SearchRangeSelector extends StatelessWidget {
  const _SearchRangeSelector();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<SearchCubit>(context);
    return BlocBuilder<SearchCubit, _SearchState>(
      builder: (context, state) {
        return SegmentedButton(
          segments: [
            ButtonSegment(
              value: ReaderSearchRange.currentChapter,
              icon: const Icon(Icons.insert_drive_file_rounded),
              label: Text(appLocalizations.readerSearchCurrentChapter),
            ),
            ButtonSegment(
              value: ReaderSearchRange.all,
              icon: const Icon(Icons.menu_book_rounded),
              label: Text(appLocalizations.readerSearchAllRange),
            ),
          ],
          style: SegmentedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          expandedInsets: const EdgeInsets.symmetric(horizontal: 4.0),
          selected: {state.range},
          onSelectionChanged: (value) => cubit.setRange(value.first),
        );
      },
    );
  }
}
