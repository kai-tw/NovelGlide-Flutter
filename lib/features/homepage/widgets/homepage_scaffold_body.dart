import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../advertisement/domain/entities/ad_unit_id.dart';
import '../../advertisement/presentation/advertisement.dart';
import '../../bookmark/presentation/bookmark_list/bookmark_list_scaffold_body.dart';
import '../../books/presentation/bookshelf/bookshelf.dart';
import '../../discover/presentation/browser/discover_browser.dart';
import '../../settings_page/presentation/settings_page.dart';
import '../cubit/homepage_cubit.dart';

class HomepageScaffoldBody extends StatelessWidget {
  const HomepageScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Advertisement(
          unitId: AdUnitId.homepage,
        ),
        Expanded(
          child: BlocBuilder<HomepageCubit, HomepageState>(
            buildWhen: (HomepageState previous, HomepageState current) =>
                previous.navItem != current.navItem,
            builder: (BuildContext context, HomepageState state) {
              switch (state.navItem) {
                case HomepageNavigationItem.bookshelf:
                  return const Bookshelf();

                case HomepageNavigationItem.discovery:
                  return const DiscoverBrowser();

                case HomepageNavigationItem.bookmark:
                  return const BookmarkListScaffoldBody();

                case HomepageNavigationItem.settings:
                  return const SettingsPage();
              }
            },
          ),
        ),
      ],
    );
  }
}
