import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../binding_center/binding_center.dart';
import '../../data/window_class.dart';
import '../../processor/theme_processor.dart';
import '../bookmark_list/bloc/bookmark_list_bloc.dart';
import '../bookmark_list/bookmark_list_sliver_list.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import '../bookshelf/bookshelf_sliver_list.dart';
import '../bookshelf/widgets/bookshelf_add_book_button.dart';
import '../settings_page/settings_page.dart';
import 'bloc/navigation_bloc.dart';
import 'homepage_app_bar.dart';
import 'homepage_nav_bar.dart';
import 'widgets/homepage_scroll_view.dart';

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

class HomepageScaffold extends StatelessWidget {
  const HomepageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(screenWidth);
    final BookshelfCubit bookshelfCubit = BlocProvider.of<BookshelfCubit>(context);
    final BookmarkListCubit bookmarkListCubit = BlocProvider.of<BookmarkListCubit>(context);

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        /// Determine the widget of body based on the current page
        final Widget bodyWidget;
        switch (state.navItem) {
          case NavigationItem.bookshelf:
            bodyWidget = RefreshIndicator(
              onRefresh: () async => bookshelfCubit.refresh(),
              child: const HomepageScrollView(
                slivers: [
                  BookshelfSliverList(),
                ],
              ),
            );
            break;

          case NavigationItem.bookmark:
            bodyWidget = RefreshIndicator(
              onRefresh: () async => bookmarkListCubit.refresh(),
              child: const SlidableAutoCloseBehavior(
                child: CustomScrollView(
                  slivers: [
                    BookmarkListSliverList(),
                  ],
                ),
              ),
            );
            break;

          case NavigationItem.settings:
            bodyWidget = const SettingsPage();
            break;
        }

        /// Display the homepage based on the window size
        switch (windowClass) {
          case WindowClass.compact:
            return Scaffold(
              extendBody: true,
              appBar: const HomepageAppBar(),
              body: bodyWidget,
              bottomNavigationBar: const HomepageNavBar(),
              floatingActionButton: state.navItem == NavigationItem.bookshelf ? const BookshelfAddBookButton() : null,
            );

          default:
            return Scaffold(
              appBar: const HomepageAppBar(),
              body: Row(
                children: [
                  const HomepageNavBar(),
                  Expanded(
                    child: bodyWidget,
                  ),
                ],
              ),
              floatingActionButton: state.navItem == NavigationItem.bookshelf ? const BookshelfAddBookButton() : null,
            );
        }
      },
    );
  }
}
