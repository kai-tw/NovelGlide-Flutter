import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarkListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(AppLocalizations.of(context)!.title_bookmarks),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
