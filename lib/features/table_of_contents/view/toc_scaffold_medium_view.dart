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
                      SizedBox(
                        width: leftWidth,
                        height: constraints.maxHeight,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, bottom: 16.0),
                              child: TocCoverBanner(aspectRatio: leftWidth / (constraints.maxHeight / 2)),
                            ),
                            const Expanded(
                              child: SingleChildScrollView(
                                child: TocBookName(),
                              ),
                            ),
                            Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                          ],
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async => BlocProvider.of<TocCubit>(context).refresh(),
                          child: const TocScrollView(
                            slivers: [
                              TocSliverChapterList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: state.isDragging ? const TocDraggingTargetBar() : const TocAddChapterButton(),
          );
        }
    );
  }
}
