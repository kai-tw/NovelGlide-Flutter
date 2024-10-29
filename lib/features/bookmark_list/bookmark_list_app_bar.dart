import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import 'widgets/bookmark_list_done_button.dart';
import 'widgets/bookmark_list_popup_menu_button.dart';
import 'widgets/bookmark_list_select_button.dart';

class BookmarkListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final WindowClass windowClass =
        WindowClass.fromWidth(MediaQuery.of(context).size.width);

    return AppBar(
      leading: const Icon(Icons.bookmarks_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(appLocalizations.bookmarkListTitle),
      actions: const [
        BookmarkListSelectButton(),
        BookmarkListDoneButton(),
        BookmarkListPopupMenuButton(),
      ],
    );
  }
}
