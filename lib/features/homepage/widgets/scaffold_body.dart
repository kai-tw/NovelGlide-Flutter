part of '../homepage.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    final HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit bookshelfCubit =
        BlocProvider.of<BookshelfCubit>(context);
    final CollectionListCubit collectionListCubit =
        BlocProvider.of<CollectionListCubit>(context);
    final BookmarkListCubit bookmarkListCubit =
        BlocProvider.of<BookmarkListCubit>(context);

    return BlocBuilder<HomepageCubit, _HomepageState>(
      buildWhen: (previous, current) => previous.navItem != current.navItem,
      builder: (context, state) {
        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            return Column(
              children: [
                Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                Expanded(
                  child: PageStorage(
                    bucket: cubit.bookshelfBucket,
                    child: RefreshIndicator(
                      onRefresh: () async => bookshelfCubit.refresh(),
                      child: const Scrollbar(
                        child: CustomScrollView(
                          key: PageStorageKey<String>('homepage-bookshelf'),
                          slivers: [
                            BookshelfSliverList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );

          case HomepageNavigationItem.collection:
            return Column(
              children: [
                Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                Expanded(
                  child: PageStorage(
                    bucket: cubit.collectionBucket,
                    child: RefreshIndicator(
                      onRefresh: () async => collectionListCubit.refresh(),
                      child: const Scrollbar(
                        child: CustomScrollView(
                          key: PageStorageKey<String>('homepage-collection'),
                          slivers: [
                            CollectionList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );

          case HomepageNavigationItem.bookmark:
            return Column(
              children: [
                Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                Expanded(
                  child: PageStorage(
                    bucket: cubit.bookmarkBucket,
                    child: RefreshIndicator(
                      onRefresh: () async => bookmarkListCubit.refresh(),
                      child: const Scrollbar(
                        child: CustomScrollView(
                          key: PageStorageKey<String>('homepage-bookmark'),
                          slivers: [
                            BookmarkListSliverList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );

          case HomepageNavigationItem.settings:
            return const SettingsPage();
        }
      },
    );
  }
}
