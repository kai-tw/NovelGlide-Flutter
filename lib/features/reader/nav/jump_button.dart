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

        final isNotLoaded = state.code != LoadingStateCode.loaded;
        final isAutoSave = state.readerSettings.autoSave;
        final isNotBookmarked = state.bookmarkData == null;
        final isDisabled = isNotBookmarked || isAutoSave || isNotLoaded;

        return IconButton(
          icon: Icon(
            Icons.bookmark_rounded,
            semanticLabel: appLocalizations.accessibilityReaderBookmarkButton,
          ),
          onPressed: isDisabled ? null : cubit.scrollToBookmark,
        );
      },
    );
  }
}
