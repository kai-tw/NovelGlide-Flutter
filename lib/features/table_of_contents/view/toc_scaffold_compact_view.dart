import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ad_center/advertisement.dart';
import '../../../ad_center/advertisement_id.dart';
import '../../../data/book_data.dart';
import '../bloc/toc_bloc.dart';
import '../toc_app_bar.dart';
import '../toc_fab_section.dart';
import '../widgets/toc_book_name.dart';
import '../widgets/toc_cover_banner.dart';
import '../widgets/toc_sliver_chapter_list.dart';

class TocScaffoldCompactView extends StatelessWidget {
  final BookData bookData;

  const TocScaffoldCompactView({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: TocAppBar(bookData: bookData),
      body: SafeArea(
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
                          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 80.0),
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
      ),
      floatingActionButton: const TocFabSection(),
    );
  }
}
