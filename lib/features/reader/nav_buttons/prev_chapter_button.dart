import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

/// The button that navigate to the previous chapter.
/// Abbreviation reference: https://www.abbreviations.com/
class RdrNavPrevChBtn extends StatelessWidget {
  const RdrNavPrevChBtn({super.key});

  @override
  Widget build(BuildContext context) {
    ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: state.prevChapterNumber == -1 ? null : () => cubit.changeChapter(state.prevChapterNumber),
        );
      },
    );
  }
}