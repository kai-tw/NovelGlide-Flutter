import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/layout/nav_content/bookmarks.dart';
import 'package:novelglide/ui/pages/main/layout/nav_content/library_list.dart';
import 'package:novelglide/ui/pages/main/layout/nav_content/settings.dart';

import '../bloc/navigation_bloc.dart';

class MainPageBodyWidget extends StatelessWidget {
  const MainPageBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Widget> tabContents = <Widget>[MainPageLibraryWidget(), BookmarkWidget(), SettingsWidget()];
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return tabContents[state.index];
      },
    );
  }
}
