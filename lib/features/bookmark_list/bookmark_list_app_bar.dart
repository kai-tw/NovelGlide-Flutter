import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarkListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.bookmark_outline_rounded),
      title: Text(AppLocalizations.of(context)!.titleBookmarks),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
