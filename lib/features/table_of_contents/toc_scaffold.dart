import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../../data/window_class.dart';
import 'bloc/toc_bloc.dart';
import 'widgets/toc_add_chapter_button.dart';
import 'widgets/toc_book_name.dart';
import 'widgets/toc_cover_banner.dart';
import 'toc_app_bar.dart';
import 'widgets/toc_scroll_view.dart';
import 'widgets/toc_sliver_list.dart';

class TocScaffold extends StatelessWidget {
  const TocScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
    final Widget bodyWidget;

    switch (windowClass) {
      case WindowClass.compact:
        bodyWidget = const TocScaffoldCompactView();
        break;
      default:
        bodyWidget = const TocScaffoldMediumView();
        break;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        Navigator.of(context).pop(cubit.state.isDirty);
      },
      child: Scaffold(
        appBar: const TocAppBar(),
        body: SlidableAutoCloseBehavior(
          child: bodyWidget,
        ),
        floatingActionButton: const TocAddChapterButton(),
        bottomNavigationBar: Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
      ),
    );
  }
}

class TocScaffoldCompactView extends StatelessWidget {
  const TocScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return RefreshIndicator(
      onRefresh: () async => cubit.refresh(),
      child: const TocScrollView(
        slivers: [
          SliverToBoxAdapter(child: TocCoverBanner()),
          SliverToBoxAdapter(child: TocBookName()),
          TocSliverList(),
        ],
      ),
    );
  }
}

class TocScaffoldMediumView extends StatelessWidget {
  const TocScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double leftWidth = constraints.maxWidth * 0.382;
      return Row(
        children: [
          SizedBox(
            width: leftWidth,
            height: constraints.maxHeight,
            child: Column(
              children: [
                TocCoverBanner(aspectRatio: leftWidth / (constraints.maxHeight / 2)),
                SizedBox(
                  height: constraints.maxHeight / 2,
                  child: const SingleChildScrollView(
                    child: TocBookName(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => cubit.refresh(),
              child: const TocScrollView(
                slivers: [
                  TocSliverList(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
