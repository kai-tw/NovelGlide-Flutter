import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import '../../processor/theme_processor.dart';
import '../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import '../collection_list/bloc/collection_list_bloc.dart';
import 'bloc/homepage_bloc.dart';
import 'view/homepage_scaffold_compact_view.dart';
import 'view/homepage_scaffold_medium_view.dart';

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
    return ThemeSwitchingArea(
      child: ThemeSwitcher(
        builder: (context) {
          _themeContext = context;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomepageCubit()),
              BlocProvider(create: (_) => BookshelfCubit()..init()),
              BlocProvider(create: (_) => CollectionListCubit()..init()),
              BlocProvider(create: (_) => BookmarkListCubit()..init()),
            ],
            child: const _HomepageScaffold(),
          );
        },
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    ThemeProcessor.onBrightnessChanged(_themeContext);
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
