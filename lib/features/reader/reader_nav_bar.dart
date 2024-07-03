import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reader_settings/reader_settings_bottom_sheet.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';
import 'widgets/reader_add_bookmark_button.dart';

class ReaderNavBar extends StatelessWidget {
  const ReaderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return SizedBox(
      height: 48.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// The buttons that navigate to the previous chapter.
          BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) => previous.prevChapterNumber != current.prevChapterNumber,
            builder: (BuildContext context, ReaderState state) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: state.prevChapterNumber == -1 ? null : () => cubit.changeChapter(state.prevChapterNumber),
              );
            },
          ),

          /// The buttons that navigate to the next chapter.
          BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) => previous.nextChapterNumber != current.nextChapterNumber,
            builder: (BuildContext context, ReaderState state) {
              return IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                onPressed: state.nextChapterNumber == -1 ? null : () => cubit.changeChapter(state.nextChapterNumber),
              );
            },
          ),

          /// The button that jump to the bookmark.
          BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) =>
                previous.readerSettings.autoSave != current.readerSettings.autoSave ||
                previous.bookmarkObject.chapterNumber != current.bookmarkObject.chapterNumber,
            builder: (BuildContext context, ReaderState state) {
              final bool isDisabled =
                  state.bookmarkObject.chapterNumber != state.chapterNumber || state.readerSettings.autoSave;
              return IconButton(
                icon: const Icon(Icons.bookmark_rounded),
                onPressed: isDisabled ? null : cubit.scrollToBookmark,
              );
            },
          ),

          /// The button that add a bookmark.
          BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) => previous.readerSettings.autoSave != current.readerSettings.autoSave,
            builder: (BuildContext context, ReaderState state) {
              return ReaderAddBookmarkButton(
                onPressed: state.readerSettings.autoSave ? null : cubit.saveBookmark,
              );
            },
          ),

          /// The button that open the setting page of the reader.
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => _navigateToSettingsPage(context),
          ),
        ],
      ),
    );
  }

  void _navigateToSettingsPage(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1.0,
      showDragHandle: true,
      barrierColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: cubit,
          child: const ReaderSettingsBottomSheet(),
        );
      },
    );
  }
}
