import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import 'bloc/toc_bloc.dart';
import 'widgets/toc_add_chapter_button.dart';
import 'widgets/toc_sliver_book_name.dart';
import 'widgets/toc_sliver_cover_banner.dart';
import 'toc_app_bar.dart';
import 'widgets/toc_sliver_list.dart';

class TocScaffold extends StatelessWidget {
  const TocScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
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
        body: RefreshIndicator(
          onRefresh: () async => cubit.refresh(),
          child: const SlidableAutoCloseBehavior(
            child: CustomScrollView(
              slivers: [
                TocSliverCoverBanner(),
                TocSliverBookName(),
                TocSliverList(),

                /// Prevent the content from being covered by the floating action button.
                SliverPadding(padding: EdgeInsets.only(bottom: 80.0)),
              ],
            ),
          ),
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
    return const Column(
      children: [
        TocSliverCoverBanner(),
        TocSliverBookName(),
        TocSliverList(),
      ],
    );
  }
}

class TocScaffoldMediumView extends StatelessWidget {
  const TocScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TocSliverCoverBanner(),
        TocSliverBookName(),
        TocSliverList(),
      ],
    );
  }
}
