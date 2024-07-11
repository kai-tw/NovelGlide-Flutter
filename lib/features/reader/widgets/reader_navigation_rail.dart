import 'package:flutter/material.dart';

import 'reader_add_bookmark_button.dart';
import 'reader_jump_to_bookmark_button.dart';
import 'reader_next_chapter_button.dart';
import 'reader_previous_chapter_button.dart';
import 'reader_settings_button.dart';

class ReaderNavigationRail extends StatelessWidget {
  const ReaderNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 64.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ReaderPreviousChapterButton(),
          ReaderNextChapterButton(),
          ReaderJumpToBookmarkButton(),
          ReaderAddBookmarkButton(),
          ReaderSettingsButton(),
        ],
      ),
    );
  }
}