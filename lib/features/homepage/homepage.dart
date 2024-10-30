import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data_model/theme_data_record.dart';
import '../../enum/window_class.dart';
import '../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../bookmark_list/bookmark_list_app_bar.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import '../bookshelf/bookshelf_app_bar.dart';
import '../collection_list/bloc/collection_list_bloc.dart';
import '../collection_list/collection_list_app_bar.dart';
import 'bloc/homepage_bloc.dart';
import 'homepage_scaffold_body.dart';
import 'homepage_tab_section.dart';
import 'widgets/homepage_navigation_bar.dart';
import 'widgets/homepage_navigation_rail.dart';

/// The homepage of the app
class Homepage extends StatefulWidget {
  final HomepageNavigationItem initialItem;

  const Homepage(
      {super.key, this.initialItem = HomepageNavigationItem.bookshelf});

  @override
  State<Homepage> createState() => _State();
}

class _State extends State<Homepage> with WidgetsBindingObserver {
  ThemeSwitcherState? _switcherState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomepageCubit(
            initialItem: widget.initialItem,
          ),
        ),
        BlocProvider(create: (_) => BookshelfCubit()),
        BlocProvider(create: (_) => CollectionListCubit()),
        BlocProvider(create: (_) => BookmarkListCubit()),
      ],
      child: ThemeSwitchingArea(
        child: ThemeSwitcher.switcher(
          builder: (context, switcher) {
            _switcherState = switcher;
            return const _Scaffold();
          },
        ),
      ),
    );
  }

  @override
  void didChangePlatformBrightness() async {
    ThemeDataRecord record = await ThemeDataRecord.fromSettings();

    if (record.brightness == null) {
      final ThemeData themeData =
          record.themeId.getThemeDataByBrightness(record.brightness);
      _switcherState?.changeTheme(theme: themeData);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(screenWidth);

    /// Display the homepage based on the window size
    switch (windowClass) {
      case WindowClass.compact:
        return const _CompactView();

      default:
        return const _MediumView();
    }
  }
}

class _CompactView extends StatelessWidget {
  const _CompactView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const _AppBar(),
      body: const HomepageScaffoldBody(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 64.0,
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 16.0,
                spreadRadius: -10.0,
                offset: const Offset(0.0, 8.0),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: const HomepageNavigationBar(),
        ),
      ),
      floatingActionButton: const HomepageTabSection(),
    );
  }
}

class _MediumView extends StatelessWidget {
  const _MediumView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const _AppBar(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              decoration: BoxDecoration(
                // color: Colors.black87,
                borderRadius: BorderRadius.circular(36.0),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    blurRadius: 16.0,
                    spreadRadius: -10.0,
                    offset: const Offset(0.0, 8.0),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: const HomepageNavigationRail(),
            ),
            const Expanded(
              child: HomepageScaffoldBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: const HomepageTabSection(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);
    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (previous, current) => previous.navItem != current.navItem,
      builder: (context, state) {
        switch (state.navItem) {
          case HomepageNavigationItem.bookshelf:
            return const BookshelfAppBar();

          case HomepageNavigationItem.collection:
            return const CollectionListAppBar();

          case HomepageNavigationItem.bookmark:
            return const BookmarkListAppBar();

          case HomepageNavigationItem.settings:
            return AppBar(
              leading: const Icon(Icons.settings_outlined),
              leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
              title: Text(AppLocalizations.of(context)!.settingsTitle),
            );
        }
      },
    );
  }
}
