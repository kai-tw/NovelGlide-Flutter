import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_add_bookmark_button_bloc.dart';

class ReaderAddBookmarkButton extends StatelessWidget {
  const ReaderAddBookmarkButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderAddBookmarkButtonCubit(),
      child: BlocBuilder<ReaderAddBookmarkButtonCubit, ReaderAddBookmarkButtonState>(
        builder: (context, state) {
          final ReaderAddBookmarkButtonCubit cubit = BlocProvider.of<ReaderAddBookmarkButtonCubit>(context);
          return IconButton(
            icon: Icon(
              state.iconData,
              semanticLabel: AppLocalizations.of(context)!.accessibilityReaderAddBookmarkButton,
            ),
            disabledColor: state.disabledColor,
            onPressed: state.isDisabled || onPressed == null
                ? null
                : () {
                    cubit.onPressedHandler();
                    onPressed!();
                  },
          );
        },
      ),
    );
  }
}
