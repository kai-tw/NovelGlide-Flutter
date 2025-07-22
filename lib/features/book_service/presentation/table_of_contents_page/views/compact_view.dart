part of '../table_of_contents.dart';

class _CompactView extends StatelessWidget {
  const _CompactView({required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final _Cubit cubit = BlocProvider.of<_Cubit>(context);
    return SafeArea(
      child: Column(
        children: <Widget>[
          const Advertisement(
            unitId: AdUnitId.tableOfContents,
          ),
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
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Stack(
                            children: <Widget>[
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
