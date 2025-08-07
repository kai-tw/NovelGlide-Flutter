part of '../table_of_contents.dart';

class _MediumView extends StatelessWidget {
  const _MediumView({required this.bookData});

  final Book bookData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: <Widget>[
              Container(
                width: constraints.maxWidth * 0.382,
                height: constraints.maxHeight,
                padding: const EdgeInsets.all(16.0),
                child: _buildLeftColumn(),
              ),
              Expanded(
                child: _buildRightColumn(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
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
        const Advertisement(
          unitId: AdUnitId.tableOfContents,
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<TocCubit>(context).refresh(),
      child: PageStorage(
        bucket: cubit.bucket,
        child: Scrollbar(
          controller: cubit.scrollController,
          child: CustomScrollView(
            key: const PageStorageKey<String>('toc-scroll-view'),
            controller: cubit.scrollController,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 80.0),
                sliver: _SliverList(bookData: bookData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
