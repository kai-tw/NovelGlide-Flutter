part of '../homepage.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomepageCubit>(context);
    final bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final collectionListCubit = BlocProvider.of<CollectionListCubit>(context);
    final bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);

    return SafeArea(
      child: BlocBuilder<HomepageCubit, _HomepageState>(
        buildWhen: (previous, current) => previous.navItem != current.navItem,
        builder: (context, state) {
          switch (state.navItem) {
            case HomepageNavigationItem.bookshelf:
              return _ScaffoldBodyColumn(
                bucket: cubit.bookshelfBucket,
                bucketKey: 'homepage-bookshelf',
                onRefresh: () async => bookshelfCubit.dragToRefresh(),
                slivers: const [
                  Bookshelf(),
                ],
              );

            case HomepageNavigationItem.collection:
              return _ScaffoldBodyColumn(
                bucket: cubit.collectionBucket,
                bucketKey: 'homepage-collection',
                onRefresh: () async => collectionListCubit.dragToRefresh(),
                slivers: const [
                  CollectionList(),
                ],
              );

            case HomepageNavigationItem.bookmark:
              return _ScaffoldBodyColumn(
                bucket: cubit.bookmarkBucket,
                bucketKey: 'homepage-bookmark',
                onRefresh: () async => bookmarkListCubit.dragToRefresh(),
                slivers: const [
                  BookmarkList(),
                ],
              );

            case HomepageNavigationItem.settings:
              return const SettingsPage();
          }
        },
      ),
    );
  }
}

class _ScaffoldBodyColumn extends StatelessWidget {
  final PageStorageBucket bucket;
  final String bucketKey;
  final Future<void> Function() onRefresh;
  final List<Widget> slivers;

  const _ScaffoldBodyColumn({
    required this.bucket,
    required this.bucketKey,
    required this.onRefresh,
    required this.slivers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
        Expanded(
          child: PageStorage(
            bucket: bucket,
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: Scrollbar(
                child: CustomScrollView(
                  key: PageStorageKey<String>(bucketKey),
                  slivers: slivers,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
