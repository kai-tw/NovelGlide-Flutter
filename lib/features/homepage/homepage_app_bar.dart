import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bookmark_list/bookmark_list_app_bar.dart';
import '../bookshelf/bookshelf_app_bar.dart';
import '../settings_page/settings_page_app_bar.dart';
import 'bloc/navigation_bloc.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomepageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        switch (state.navItem) {
          case NavigationItem.bookshelf:
            return const BookshelfAppBar();
          case NavigationItem.bookmark:
            return const BookmarkListAppBar();
          case NavigationItem.settings:
            return const SettingsPageAppBar();
        }
      },
    );
  }
}