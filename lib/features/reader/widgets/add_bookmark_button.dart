import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_button_state.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

/// The button that save current scrolling position to the bookmark.
/// Abbreviation reference: https://www.abbreviations.com/
class RdrNavAddBkmBtn extends StatelessWidget {
  const RdrNavAddBkmBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);

    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        IconData iconData = Icons.bookmark_add_rounded;
        Color? disabledColor;
        void Function()? onPressed;

        switch (state.buttonState.addBkmState) {
          case RdrBtnAddBkmState.normal:
            onPressed = readerCubit.onClickedAddBkmBtn;
            break;
          case RdrBtnAddBkmState.done:
            iconData = Icons.check_rounded;
            disabledColor = Colors.green;
            break;
          case RdrBtnAddBkmState.disabled:
        }

        return IconButton(
          icon: Icon(iconData),
          disabledColor: disabledColor,
          onPressed: onPressed,
        );
      },
    );
  }
}
