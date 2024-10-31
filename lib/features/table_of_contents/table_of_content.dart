import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/book_data.dart';
import '../../enum/window_class.dart';
import '../ads/advertisement.dart';
import 'bloc/toc_bloc.dart';
import 'toc_app_bar.dart';
import 'toc_fab_section.dart';
import 'widgets/toc_book_name.dart';
import 'widgets/toc_cover_banner.dart';
import 'widgets/toc_sliver_chapter_list.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookData, {super.key});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass =
        WindowClass.fromWidth(MediaQuery.of(context).size.width);
    Widget body;

    switch (windowClass) {
      case WindowClass.compact:
        body = _CompactView(bookData: bookData);
        break;

      default:
        body = _MediumView(bookData: bookData);
    }

    return BlocProvider(
      create: (_) => TocCubit(bookData)..init(),
      child: Scaffold(
        appBar: TocAppBar(bookData: bookData),
        body: body,
        floatingActionButton: const TocFabSection(),
      ),
    );
  }
}

class _CompactView extends StatelessWidget {
  final BookData bookData;

  const _CompactView({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TocCubit>(context);
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
                                child: TocCoverBanner(bookData: bookData),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TocBookName(bookData: bookData),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 80.0),
                        sliver: TocSliverChapterList(bookData: bookData),
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

class _MediumView extends StatelessWidget {
  final BookData bookData;

  const _MediumView({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TocCubit>(context);

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
                          TocCoverBanner(bookData: bookData),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: TocBookName(bookData: bookData),
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
                      BlocProvider.of<TocCubit>(context).refresh(),
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
                            sliver: TocSliverChapterList(bookData: bookData),
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
