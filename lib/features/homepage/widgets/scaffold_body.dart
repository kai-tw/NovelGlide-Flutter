part of '../homepage.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          const Advertisement(
            unitId: AdUnitId.homepage,
          ),
          Expanded(
            child: BlocBuilder<HomepageCubit, HomepageState>(
              buildWhen: (HomepageState previous, HomepageState current) =>
                  previous.navItem != current.navItem,
              builder: (BuildContext context, HomepageState state) {
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
          ),
        ],
      ),
    );
  }
}
