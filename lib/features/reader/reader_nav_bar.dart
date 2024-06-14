import 'package:flutter/material.dart';

import 'widgets/add_bookmark_button.dart';
import 'widgets/next_chapter_button.dart';
import 'widgets/prev_chapter_button.dart';
import 'widgets/jump_to_bookmark_button.dart';
import 'widgets/settings_button.dart';

class ReaderNavBar extends StatelessWidget {
  const ReaderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 48.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RdrNavPrevChBtn(),
          RdrNavNxtChBtn(),
          RdrNavJmpToBkmBtn(),
          RdrNavAddBkmBtn(),
          RdrNavSettingsBtn(),
        ],
      ),
    );
  }
}
