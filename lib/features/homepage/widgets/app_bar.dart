part of '../homepage.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

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
            return const BookListAppBar();

          case HomepageNavigationItem.collection:
            return const CollectionListAppBar();

          case HomepageNavigationItem.bookmark:
            return const BookmarkListAppBar();

          case HomepageNavigationItem.settings:
            return const SettingsAppBar();
        }
      },
    );
  }
}
