import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../book_importer/book_importer_scaffold.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import 'bloc/navigation_bloc.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        switch (state.navItem) {
          case NavigationItem.bookshelf:
            return AppBar(
              leading: const Icon(Icons.book_outlined),
              title: Text(appLocalizations.titleBookshelf),
            );
          case NavigationItem.bookmark:
            return AppBar(
              leading: const Icon(Icons.bookmark_outline_rounded),
              title: Text(AppLocalizations.of(context)!.titleBookmarks),
            );
          case NavigationItem.settings:
            return AppBar(
              leading: const Icon(Icons.settings_outlined),
              title: Text(AppLocalizations.of(context)!.titleSettings),
            );
        }
      },
    );
  }
}
