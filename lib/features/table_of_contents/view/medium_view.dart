part of '../table_of_contents.dart';

class _MediumView extends StatelessWidget {
  const _MediumView({required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final _Cubit cubit = BlocProvider.of<_Cubit>(context);

    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double leftWidth = constraints.maxWidth * 0.382;
          return Row(
            children: <Widget>[
              Container(
                width: leftWidth,
                height: constraints.maxHeight,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
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
                        slivers: <Widget>[
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
