import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import '../common_components/settings_section_card.dart';
import 'widgets/bookmark_manager_clear_all_button.dart';

class BookmarkManagerScaffold extends StatelessWidget {
  const BookmarkManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(AppLocalizations.of(context)!.titleBookmarkManager),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsSectionCard(
              children: [
                BookmarkManagerClearAllButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}