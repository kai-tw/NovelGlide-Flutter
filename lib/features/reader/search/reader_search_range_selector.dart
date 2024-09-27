import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_search_cubit.dart';

class ReaderSearchRangeSelector extends StatelessWidget {
  const ReaderSearchRangeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSearchCubit cubit = BlocProvider.of<ReaderSearchCubit>(context);
    return BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
      builder: (context, state) {
        return SegmentedButton(
          segments: [
            ButtonSegment(
              value: ReaderSearchRange.currentChapter,
              icon: const Icon(Icons.insert_drive_file_rounded),
              label: Text(AppLocalizations.of(context)!.readerSearchCurrentChapter),
            ),
            ButtonSegment(
              value: ReaderSearchRange.all,
              icon: const Icon(Icons.menu_book_rounded),
              label: Text(AppLocalizations.of(context)!.readerSearchAllRange),
            ),
          ],
          style: SegmentedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          expandedInsets: const EdgeInsets.symmetric(horizontal: 4.0),
          selected: {state.range},
          onSelectionChanged: (value) => cubit.searchRange = value.first,
        );
      },
    );
  }
}
