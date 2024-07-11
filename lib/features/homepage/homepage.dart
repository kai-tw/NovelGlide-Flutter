import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../binding_center/binding_center.dart';
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
import 'widgets/homepage_dragging_target_bar.dart';

/// The homepage of the app
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: ThemeSwitcher(
        builder: (context) {
          ThemeBinding.instance.addBrightnessListener("ThemeManager", (_) {
            ThemeProcessor.onBrightnessChanged(context);
          });

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomepageCubit()),
              BlocProvider(create: (_) => NavigationCubit()),
              BlocProvider(create: (_) => BookshelfCubit()..refresh()),
              BlocProvider(create: (_) => BookmarkListCubit()..refresh()),
            ],
            child: const HomepageScaffold(),
          );
        },
      ),
    );
  }
}

/// The scaffold of the homepage
class HomepageScaffold extends StatelessWidget {
  const HomepageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(screenWidth);

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        /// Display the homepage based on the window size
        switch (windowClass) {
          case WindowClass.compact:
            return Scaffold(
              extendBody: true,
              appBar: const HomepageAppBar(),
              body: const HomepageScaffoldBody(),
              bottomNavigationBar: const HomepageNavBar(),
              floatingActionButton: state.navItem == NavigationItem.bookshelf ? const BookshelfAddBookButton() : null,
            );

          default:
            return BlocBuilder<HomepageCubit, HomepageState>(
                builder: (BuildContext context, HomepageState homepageState) {
              return Scaffold(
                appBar: const HomepageAppBar(),
                body: const Row(
                  children: [
                    HomepageNavBar(),
                    Expanded(
                      child: HomepageScaffoldBody(),
                    ),
                  ],
                ),
                floatingActionButton: homepageState.isDragging
                    ? const HomepageDraggingTargetBar()
                    : state.navItem == NavigationItem.bookshelf
                        ? const BookshelfAddBookButton()
                        : null,
              );
            });
        }
      },
    );
  }
}
