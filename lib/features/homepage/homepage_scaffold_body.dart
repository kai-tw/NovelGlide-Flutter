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
            return RefreshIndicator(
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
            );

          case NavigationItem.bookmark:
            return RefreshIndicator(
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
            );

          case NavigationItem.settings:
            return const SettingsPage();
        }
      },
    );
  }
}