import 'package:flutter/material.dart';

import 'nav_buttons/add_bookmark_button.dart';
import 'nav_buttons/next_chapter_button.dart';
import 'nav_buttons/prev_chapter_button.dart';
import 'nav_buttons/scroll_to_bookmark_button.dart';
import 'nav_buttons/settings_button.dart';

class ReaderNavBar extends StatelessWidget {
  const ReaderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 48.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ReaderNavPrevChapterButton(),
          ReaderNavNextChapterButton(),
          ReaderNavScrollToBookmarkButton(),
          ReaderNavAddBookmarkButton(),
          ReaderNavSettingsButton(),
        ],
      ),
    );
  }
}
