part of '../table_of_contents.dart';

class _MediumView extends StatelessWidget {
  final BookData bookData;

  const _MediumView({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);

    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double leftWidth = constraints.maxWidth * 0.382;
          return Row(
            children: [
              Container(
                width: leftWidth,
                height: constraints.maxHeight,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          _CoverBanner(bookData: bookData),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: _BookName(bookData: bookData),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      BlocProvider.of<_Cubit>(context).refresh(),
                  child: PageStorage(
                    bucket: cubit.bucket,
                    child: Scrollbar(
                      controller: cubit.scrollController,
                      child: CustomScrollView(
                        key: const PageStorageKey<String>('toc-scroll-view'),
                        controller: cubit.scrollController,
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(
                                24.0, 0.0, 24.0, 80.0),
                            sliver: _SliverList(bookData: bookData),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
