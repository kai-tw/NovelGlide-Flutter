import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ad_center/advertisement.dart';
import '../../../ad_center/advertisement_id.dart';
import '../bloc/toc_bloc.dart';
import '../toc_app_bar.dart';
import '../widgets/toc_add_chapter_button.dart';
import '../widgets/toc_book_name.dart';
import '../widgets/toc_cover_banner.dart';
import '../widgets/toc_dragging_target_bar.dart';
import '../widgets/toc_scroll_view.dart';
import '../chapter_list/toc_sliver_chapter_list.dart';

class TocScaffoldCompactView extends StatelessWidget {
  const TocScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return Scaffold(
      extendBody: true,
      appBar: const TocAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async => cubit.refresh(),
              child: Column(
                children: [
                  Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                  const Expanded(
                    child: TocScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: TocCoverBanner(),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TocBookName(),
                        ),
                        TocSliverChapterList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 72.0,
                  child: const TocDraggingTargetBar(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const TocAddChapterButton(),
    );
  }
}
