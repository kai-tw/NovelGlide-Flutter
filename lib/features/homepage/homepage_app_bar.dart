import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bookmark_list/bookmark_list_app_bar.dart';
import '../bookshelf/bookshelf_app_bar.dart';
import 'bloc/homepage_bloc.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (previous, current) => previous.navItem != current.navItem,
      builder: (context, state) {
        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            return const BookshelfAppBar();
          case HomepageNavigationItem.bookmark:
            return const BookmarkListAppBar();
          case HomepageNavigationItem.settings:
            return AppBar(
              leading: const Icon(Icons.settings_outlined),
              title: Text(AppLocalizations.of(context)!.settingsTitle),
            );
        }
      },
    );
  }
}
