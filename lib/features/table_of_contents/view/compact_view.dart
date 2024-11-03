part of '../table_of_contents.dart';

class _CompactView extends StatelessWidget {
  final BookData bookData;

  const _CompactView({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);
    return SafeArea(
      child: Column(
        children: [
          Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => cubit.refresh(),
              child: PageStorage(
                bucket: cubit.bucket,
                child: Scrollbar(
                  controller: cubit.scrollController,
                  child: CustomScrollView(
                    key: const PageStorageKey<String>('toc-scroll-view'),
                    controller: cubit.scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: _CoverBanner(bookData: bookData),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: _BookName(bookData: bookData),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 80.0),
                        sliver: _SliverList(bookData: bookData),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
