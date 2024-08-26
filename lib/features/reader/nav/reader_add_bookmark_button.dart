import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_add_bookmark_button_bloc.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderAddBookmarkButton extends StatelessWidget {
  const ReaderAddBookmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.autoSave != current.readerSettings.autoSave || previous.code != current.code,
      builder: (BuildContext context, ReaderState readerState) {
        return BlocProvider(
          create: (_) => ReaderAddBookmarkButtonCubit(),
          child: BlocBuilder<ReaderAddBookmarkButtonCubit, ReaderAddBookmarkButtonState>(
            builder: (BuildContext context, ReaderAddBookmarkButtonState state) {
              final ReaderAddBookmarkButtonCubit cubit = BlocProvider.of<ReaderAddBookmarkButtonCubit>(context);
              final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
              final bool isDisabled =
                  readerState.readerSettings.autoSave || state.isDisabled || readerState.code != ReaderStateCode.loaded;
              return IconButton(
                icon: Icon(
                  state.iconData,
                  semanticLabel: AppLocalizations.of(context)!.accessibilityReaderAddBookmarkButton,
                ),
                disabledColor: state.disabledColor,
                onPressed: isDisabled ? null : () => _onPressed(readerCubit, cubit),
              );
            },
          ),
        );
      },
    );
  }

  void _onPressed(ReaderCubit readerCubit, ReaderAddBookmarkButtonCubit cubit) {
    cubit.onPressedHandler();
    readerCubit.saveBookmark();
  }
}
