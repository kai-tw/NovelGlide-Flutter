import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../../bookshelf/bloc/bookshelf_bloc.dart';
import '../bloc/homepage_bloc.dart';

class HomepageNavigationBar extends StatelessWidget {
  const HomepageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<HomepageCubit>(context);
    final bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);

    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (previous, current) => previous.navItem != current.navItem,
      builder: (context, state) {
        return NavigationBar(
          selectedIndex: HomepageNavigationItem.values.indexOf(state.navItem),
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            _Destination(
              iconData: Icons.shelves,
              label: appLocalizations.bookshelfTitle,
              enabled: state.navItem != HomepageNavigationItem.bookshelf,
            ),
            _Destination(
              iconData: Icons.collections_bookmark_rounded,
              label: appLocalizations.collectionTitle,
              enabled: state.navItem != HomepageNavigationItem.collection,
            ),
            _Destination(
              iconData: Icons.bookmarks_rounded,
              label: appLocalizations.bookmarkListTitle,
              enabled: state.navItem != HomepageNavigationItem.bookmark,
            ),
            _Destination(
              iconData: Icons.settings_rounded,
              label: appLocalizations.settingsTitle,
              enabled: state.navItem != HomepageNavigationItem.settings,
            ),
          ],
          onDestinationSelected: (index) {
            switch (state.navItem) {
              case HomepageNavigationItem.bookshelf:
                bookshelfCubit.unfocused();
                break;
              case HomepageNavigationItem.bookmark:
                bookmarkListCubit.unfocused();
                break;
              default:
            }
            cubit.setItem(HomepageNavigationItem.values[
                index.clamp(0, HomepageNavigationItem.values.length - 1)]);
          },
        );
      },
    );
  }
}

class _Destination extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool enabled;

  const _Destination({
    required this.iconData,
    required this.label,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return NavigationDestination(
      icon: Icon(iconData, color: colorScheme.onSurface.withOpacity(0.64)),
      selectedIcon: Icon(iconData, color: colorScheme.onSurface),
      label: label,
      enabled: enabled,
    );
  }
}
