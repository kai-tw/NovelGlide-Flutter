import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../bloc/reader_cubit.dart';
import '../../bloc/reader_state.dart';

class ReaderNavPreviousButton extends StatelessWidget {
  const ReaderNavPreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!
                .accessibilityReaderPrevChapterButton,
          ),
          onPressed: state.code.isLoaded
              ? () => cubit.state.isRtl
                  ? cubit.webViewHandler.nextPage()
                  : cubit.webViewHandler.prevPage()
              : null,
        );
      },
    );
  }
}
