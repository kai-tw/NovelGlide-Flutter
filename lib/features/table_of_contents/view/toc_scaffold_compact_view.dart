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
    return BlocBuilder<TocCubit, TocState>(
        buildWhen: (previous, current) => previous.isDragging != current.isDragging,
        builder: (context, state) {
          return Scaffold(
            appBar: const TocAppBar(),
            body: SafeArea(
              child: RefreshIndicator(
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
            ),
            floatingActionButton: const TocAddChapterButton(),
            bottomNavigationBar: state.isDragging ? const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: TocDraggingTargetBar(),
            ) : null,
          );
        }
    );
  }
}
