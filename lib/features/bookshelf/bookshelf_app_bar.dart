import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import 'widgets/bookshelf_done_button.dart';
import 'widgets/bookshelf_popup_menu_button.dart';
import 'widgets/bookshelf_select_button.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    return AppBar(
      leading: const Icon(Icons.book_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(appLocalizations.bookshelfTitle),
      actions: const [
        BookshelfSelectButton(),
        BookshelfDoneButton(),
        BookshelfPopupMenuButton(),
      ],
    );
  }
}
