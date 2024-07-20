import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';

class TocContinueReadingButton extends StatelessWidget {
  const TocContinueReadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return BlocBuilder<TocCubit, TocState>(
      builder: (BuildContext context, TocState state) {
        return state.bookmarkData.isValid
            ? ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => ReaderWidget(
                                state.bookmarkData.bookName,
                                state.bookmarkData.chapterNumber,
                                isAutoJump: true,
                              )))
                      .then((_) => cubit.refresh());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  fixedSize: const Size.fromHeight(56.0),
                  elevation: 5.0,
                ),
                icon: const Icon(Icons.bookmark_rounded),
                label: Text(AppLocalizations.of(context)!.continueReading),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
