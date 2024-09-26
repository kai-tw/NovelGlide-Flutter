import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/theme_data_record.dart';
import '../../enum/window_class.dart';
import '../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import '../collection_list/bloc/collection_list_bloc.dart';
import 'bloc/homepage_bloc.dart';
import 'view/homepage_scaffold_compact_view.dart';
import 'view/homepage_scaffold_medium_view.dart';

/// The homepage of the app
class Homepage extends StatefulWidget {
  final HomepageNavigationItem initialItem;

  const Homepage({super.key, this.initialItem = HomepageNavigationItem.bookshelf});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  ThemeSwitcherState? _switcherState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: ThemeSwitcher.switcher(
        builder: (context, switcher) {
          _switcherState = switcher;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomepageCubit(initialItem: widget.initialItem)),
              BlocProvider(create: (_) => BookshelfCubit()),
              BlocProvider(create: (_) => CollectionListCubit()),
              BlocProvider(create: (_) => BookmarkListCubit()),
            ],
            child: const _HomepageScaffold(),
          );
        },
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    ThemeDataRecord record = ThemeDataRecord.fromSettings();

    if (record.brightness == null) {
      final ThemeData themeData = record.themeId.getThemeDataByBrightness(brightness: record.brightness);
      _switcherState?.changeTheme(theme: themeData);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _HomepageScaffold extends StatelessWidget {
  const _HomepageScaffold();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClass.getClassByWidth(screenWidth);

    /// Display the homepage based on the window size
    switch (windowClass) {
      case WindowClass.compact:
        return const HomepageScaffoldCompactView();

      default:
        return const HomepageScaffoldMediumView();
    }
  }
}
