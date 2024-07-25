import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ad_center/advertisement.dart';
import '../../../ad_center/advertisement_id.dart';
import '../bloc/toc_bloc.dart';
import '../toc_app_bar.dart';
import '../toc_fab_section.dart';
import '../widgets/toc_book_name.dart';
import '../widgets/toc_cover_banner.dart';
import '../widgets/toc_scroll_view.dart';
import '../chapter_list/toc_sliver_chapter_list.dart';

class TocScaffoldCompactView extends StatelessWidget {
  const TocScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const TocAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
            Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async => cubit.refresh(),
                    child: const TocScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: TocCoverBanner(),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: TocBookName(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TocSliverChapterList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const TocFabSection(),
    );
  }
}
