import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderNextChapterButton extends StatelessWidget {
  const ReaderNextChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.atEnd != current.atEnd,
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            semanticLabel: AppLocalizations.of(context)!.accessibilityReaderNextChapterButton,
          ),
          onPressed: state.atEnd ? null : () => cubit.nextPage(),
        );
      },
    );
  }
}
