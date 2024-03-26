import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_button_state.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

/// The button that jump to the bookmark.
/// Abbreviation reference: https://www.abbreviations.com/
class RdrNavJmpToBkmBtn extends StatelessWidget {
  const RdrNavJmpToBkmBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);

    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        void Function()? onPressed;

        switch (state.buttonState.jmpToBkmState) {
          case RdrBtnJmpToBkmState.normal:
            onPressed = readerCubit.onClickedJmpToBkmBtn;
            break;
          case RdrBtnJmpToBkmState.disabled:
            onPressed = null;
        }

        return IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.bookmark_rounded),
        );
      },
    );
  }
}
