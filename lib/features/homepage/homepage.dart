import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import '../../processor/theme_processor.dart';
import '../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import '../bookshelf/widgets/bookshelf_add_book_button.dart';
import 'bloc/homepage_bloc.dart';
import 'bloc/navigation_bloc.dart';
import 'homepage_app_bar.dart';
import 'homepage_nav_bar.dart';
import 'homepage_scaffold_body.dart';
import 'view/homepage_scaffold_compact_view.dart';
import 'view/homepage_scaffold_medium_view.dart';
import 'widgets/homepage_dragging_target_bar.dart';

/// The homepage of the app
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  late BuildContext _themeContext;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClass.getClassByWidth(screenWidth);
    Widget scaffold;

    /// Display the homepage based on the window size
    switch (windowClass) {
      case WindowClass.compact:
        scaffold = const HomepageScaffoldCompactView();

      default:
        scaffold = const HomepageScaffoldMediumView();
    }

    return ThemeSwitchingArea(
      child: ThemeSwitcher(
        builder: (context) {
          _themeContext = context;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomepageCubit()),
              BlocProvider(create: (_) => NavigationCubit()),
              BlocProvider(create: (_) => BookshelfCubit()..refresh()),
              BlocProvider(create: (_) => BookmarkListCubit()..refresh()),
            ],
            child: scaffold,
          );
        },
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    ThemeProcessor.onBrightnessChanged(_themeContext);
  }
}
