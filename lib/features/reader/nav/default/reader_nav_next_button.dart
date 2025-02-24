import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/reader_cubit.dart';
import '../../bloc/reader_state.dart';

class ReaderNavNextButton extends StatelessWidget {
  const ReaderNavNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!
                .accessibilityReaderNextChapterButton,
          ),
          onPressed: state.code.isLoaded
              ? () => cubit.state.isRtl
                  ? cubit.webViewHandler.prevPage()
                  : cubit.webViewHandler.nextPage()
              : null,
        );
      },
    );
  }
}
