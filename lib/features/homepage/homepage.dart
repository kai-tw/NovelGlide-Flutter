library homepage_widget;

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data_model/theme_data_record.dart';
import '../../enum/window_class.dart';
import '../ads/advertisement.dart';
import '../book_add/book_add_dialog.dart';
import '../bookmark_list/bookmark_list.dart';
import '../bookshelf/bookshelf.dart';
import '../collection_add/collection_add_dialog.dart';
import '../collection_list/bloc/collection_list_bloc.dart';
import '../collection_list/collection_list.dart';
import '../collection_list/collection_list_app_bar.dart';
import '../collection_list/collection_list_operation_panel.dart';
import '../settings_page/settings_page.dart';

part 'bloc/cubit.dart';
part 'view/compact_view.dart';
part 'view/medium_view.dart';
part 'widgets/app_bar.dart';
part 'widgets/floating_action_button.dart';
part 'widgets/floating_action_widget.dart';
part 'widgets/navigation_bar.dart';
part 'widgets/navigation_rail.dart';
part 'widgets/scaffold_body.dart';

/// The homepage of the app
class Homepage extends StatefulWidget {
  final HomepageNavigationItem initialItem;

  const Homepage({
    super.key,
    this.initialItem = HomepageNavigationItem.bookshelf,
  });

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
