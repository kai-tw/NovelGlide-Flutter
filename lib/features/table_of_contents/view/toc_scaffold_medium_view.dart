import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ad_center/advertisement.dart';
import '../../../ad_center/advertisement_id.dart';
import '../bloc/toc_bloc.dart';
import '../toc_app_bar.dart';
import '../widgets/toc_add_chapter_button.dart';
import '../widgets/toc_book_name.dart';
import '../widgets/toc_continue_reading_button.dart';
import '../widgets/toc_cover_banner.dart';
import '../widgets/toc_dragging_target_bar.dart';
import '../widgets/toc_scroll_view.dart';
import '../chapter_list/toc_sliver_chapter_list.dart';

class TocScaffoldMediumView extends StatelessWidget {
  const TocScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TocCubit, TocState>(
      buildWhen: (previous, current) => previous.isDragging != current.isDragging,
      builder: (context, state) {
        return Scaffold(
          appBar: const TocAppBar(),
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
                          const Expanded(
                            child: Stack(
                              children: [
                                TocCoverBanner(),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: TocBookName(),
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
                      child: Stack(
                        children: [
                          RefreshIndicator(
                            onRefresh: () async => BlocProvider.of<TocCubit>(context).refresh(),
                            child: const TocScrollView(
                              slivers: [
                                TocSliverChapterList(),
                              ],
                            ),
                          ),
                          const Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child:  TocDraggingTargetBar(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          floatingActionButton: const TocAddChapterButton(),
        );
      },
    );
  }
}
