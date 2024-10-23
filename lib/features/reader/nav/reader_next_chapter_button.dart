import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/loading_state_code.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderNextChapterButton extends StatelessWidget {
  const ReaderNextChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.atStart != current.atStart ||
          previous.atEnd != current.atEnd ||
          previous.isRtl != current.isRtl,
      builder: (BuildContext context, ReaderState state) {
        final isDisabled = state.code != LoadingStateCode.loaded ||
            (state.isRtl && state.atStart) ||
            (!state.isRtl && state.atEnd);
        return IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!
                .accessibilityReaderNextChapterButton,
          ),
          onPressed: isDisabled
              ? null
              : state.isRtl
                  ? () => cubit.prevPage()
                  : () => cubit.nextPage(),
        );
      },
    );
  }
}
