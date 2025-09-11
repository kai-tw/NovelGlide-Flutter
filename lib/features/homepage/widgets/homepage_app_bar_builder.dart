import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bookmark/presentation/bookmark_list/bookmark_list_app_bar.dart';
import '../../books/presentation/bookshelf/bookshelf_app_bar.dart';
import '../../explore/presentation/browser/explore_app_bar.dart';
import '../../settings_page/presentation/settings_app_bar.dart';
import '../cubit/homepage_cubit.dart';

class HomepageAppBarBuilder extends StatelessWidget
    implements PreferredSizeWidget {
  const HomepageAppBarBuilder({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (HomepageState previous, HomepageState current) =>
          previous.navItem != current.navItem,
      builder: (BuildContext context, HomepageState state) {
        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            return const BookshelfAppBar();

          case HomepageNavigationItem.discovery:
            return const ExploreAppBar();

          case HomepageNavigationItem.bookmark:
            return const BookmarkListAppBar();

          case HomepageNavigationItem.settings:
            return const SettingsAppBar();
        }
      },
    );
  }
}
