part of 'reader_default_navigation.dart';

class ReaderNavBookmarkButton extends StatelessWidget {
  const ReaderNavBookmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.bookmarkData != current.bookmarkData ||
          previous.startCfi != current.startCfi ||
          previous.ttsState != current.ttsState ||
          previous.readerSettings.isAutoSaving !=
              current.readerSettings.isAutoSaving,
      builder: (context, state) {
        // Was the current page bookmarked?
        final isBookmarked = !state.readerSettings.isAutoSaving &&
            state.bookmarkData?.startCfi == state.startCfi;

        // Can the current page be bookmarked?
        final isEnabled = state.code.isLoaded &&
            state.ttsState.isStopped &&
            !state.readerSettings.isAutoSaving &&
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
