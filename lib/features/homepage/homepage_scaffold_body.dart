import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../bookmark_list/bookmark_list_sliver_list.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import '../bookshelf/bookshelf_sliver_list.dart';
import '../settings_page/settings_page.dart';
import 'bloc/navigation_bloc.dart';
import 'widgets/homepage_dragging_target_bar.dart';
import 'widgets/homepage_scroll_view.dart';

class HomepageScaffoldBody extends StatelessWidget {
  const HomepageScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        final BookshelfCubit bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
        final BookmarkListCubit bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);

        switch (state.navItem) {
          case NavigationItem.bookshelf:
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async => bookshelfCubit.refresh(),
                  child: Column(
                    children: [
                      Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                      const Expanded(
                        child: HomepageScrollView(
                          slivers: [
                            BookshelfSliverList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  bottom: kFloatingActionButtonMargin - 8.0 + MediaQuery.of(context).padding.bottom,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 72.0,
                      child: const HomepageDraggingTargetBar(),
                    ),
                  ),
                ),
              ],
            );

          case NavigationItem.bookmark:
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async => bookmarkListCubit.refresh(),
                  child: Column(
                    children: [
                      Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                      const Expanded(
                        child: HomepageScrollView(
                          slivers: [
                            BookmarkListSliverList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  bottom: kFloatingActionButtonMargin - 8.0 + MediaQuery.of(context).padding.bottom,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child:HomepageDraggingTargetBar(),
                  ),
                ),
              ],
            );

          case NavigationItem.settings:
            return const SettingsPage();
        }
      },
    );
  }
}
