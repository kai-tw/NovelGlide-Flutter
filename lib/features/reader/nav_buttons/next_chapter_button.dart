import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

/// The button that navigate to the next chapter.
/// Abbreviation reference: https://www.abbreviations.com/
class RdrNavNxtChBtn extends StatelessWidget {
  const RdrNavNxtChBtn({super.key});

  @override
  Widget build(BuildContext context) {
    ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: state.nextChapterNumber == -1 ? null : () => cubit.changeChapter(state.nextChapterNumber),
        );
      },
    );
  }
}