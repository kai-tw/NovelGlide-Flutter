part of '../homepage.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomepageCubit, _HomepageState>(
        buildWhen: (_HomepageState previous, _HomepageState current) =>
            previous.navItem != current.navItem,
        builder: (BuildContext context, _HomepageState state) {
          switch (state.navItem) {
            case HomepageNavigationItem.bookshelf:
              return const BookshelfScaffoldBody();

            case HomepageNavigationItem.collection:
              return const CollectionListScaffoldBody();

            case HomepageNavigationItem.bookmark:
              return const BookmarkListScaffoldBody();

            case HomepageNavigationItem.settings:
              return const SettingsPage();
          }
        },
      ),
    );
  }
}
