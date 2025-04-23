part of '../homepage.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomepageCubit, _HomepageState>(
        buildWhen: (previous, current) => previous.navItem != current.navItem,
        builder: (context, state) {
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
