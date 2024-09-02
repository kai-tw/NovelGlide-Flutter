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

class TocScaffoldMediumView extends StatelessWidget {
  final BookData bookData;

  const TocScaffoldMediumView({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);

    return Scaffold(
      appBar: TocAppBar(bookData: bookData),
      body: SafeArea(
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
                    onRefresh: () async => BlocProvider.of<TocCubit>(context).refresh(),
                    child: PageStorage(
                      bucket: cubit.bucket,
                      child: Scrollbar(
                        controller: cubit.scrollController,
                        child: CustomScrollView(
                          key: const PageStorageKey<String>('toc-scroll-view'),
                          controller: cubit.scrollController,
                          slivers: [
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
            );
          },
        ),
      ),
      floatingActionButton: const TocFabSection(),
    );
  }
}
