part of '../homepage.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowClass windowClass = WindowClass.fromWidth(windowWidth);
    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (HomepageState previous, HomepageState current) =>
          previous.navItem != current.navItem,
      builder: (BuildContext context, HomepageState state) {
        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            return const BookshelfAppBar();

          case HomepageNavigationItem.collection:
            return const CollectionListAppBar();

          case HomepageNavigationItem.bookmark:
            return const BookmarkListAppBar();

          case HomepageNavigationItem.settings:
            return AppBar(
              leading: const Icon(Icons.settings_outlined),
              leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
              title: Text(AppLocalizations.of(context)!.settingsTitle),
            );
        }
      },
    );
  }
}
