part of '../reader.dart';

/// Jump to bookmark button
class _JumpToButton extends StatelessWidget {
  const _JumpToButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.autoSave != current.readerSettings.autoSave ||
          previous.bookmarkData?.startCfi != current.bookmarkData?.startCfi ||
          previous.code != current.code ||
          previous.startCfi != current.startCfi,
      builder: (BuildContext context, _ReaderState state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final cubit = BlocProvider.of<_ReaderCubit>(context);
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
