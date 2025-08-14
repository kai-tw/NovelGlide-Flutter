part of '../../../reader.dart';

class ReaderNavBookmarkButton extends StatelessWidget {
  const ReaderNavBookmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.code != current.code ||
          previous.bookmarkData != current.bookmarkData ||
          previous.startCfi != current.startCfi ||
          previous.ttsState != current.ttsState ||
          previous.readerPreference.isAutoSaving !=
              current.readerPreference.isAutoSaving,
      builder: (BuildContext context, ReaderState state) {
        // Was the current page bookmarked?
        final bool isBookmarked = !state.readerPreference.isAutoSaving &&
            state.bookmarkData?.startCfi == state.startCfi;

        // Can the current page be bookmarked?
        final bool isEnabled = state.code.isLoaded &&
            state.ttsState.isReady &&
            !state.readerPreference.isAutoSaving &&
            state.bookmarkData?.startCfi != state.startCfi;

        return IconButton(
          icon: Icon(
            isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_outline_rounded,
          ),
          tooltip: appLocalizations.readerBookmark,
          style: IconButton.styleFrom(
            disabledForegroundColor: isBookmarked ? colorScheme.error : null,
          ),
          onPressed: isEnabled ? () => cubit.saveBookmark() : null,
        );
      },
    );
  }
}
