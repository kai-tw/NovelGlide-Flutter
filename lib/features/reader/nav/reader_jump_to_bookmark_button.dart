import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/loading_state_code.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderJumpToBookmarkButton extends StatelessWidget {
  const ReaderJumpToBookmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.autoSave != current.readerSettings.autoSave ||
          previous.bookmarkData?.startCfi != current.bookmarkData?.startCfi ||
          previous.code != current.code ||
          previous.startCfi != current.startCfi,
      builder: (BuildContext context, ReaderState state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final cubit = BlocProvider.of<ReaderCubit>(context);
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        final isNotLoaded = state.code != LoadingStateCode.loaded;
        final isAtBookmark = state.bookmarkData?.startCfi == state.startCfi;
        final isAutoSave = state.readerSettings.autoSave;
        final isNotBookmarked = state.bookmarkData == null;
        final isDisabled =
            isNotBookmarked || isAtBookmark || isAutoSave || isNotLoaded;

        return IconButton(
          icon: Icon(
            Icons.bookmark_rounded,
            semanticLabel: appLocalizations.accessibilityReaderBookmarkButton,
          ),
          style: IconButton.styleFrom(
            disabledForegroundColor:
                isAtBookmark && !isAutoSave ? colorScheme.error : null,
          ),
          onPressed: isDisabled ? null : cubit.scrollToBookmark,
        );
      },
    );
  }
}
