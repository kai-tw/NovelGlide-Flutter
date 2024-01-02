import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/layout/navigation_content/bookmarks.dart';
import 'package:novelglide/ui/pages/main/layout/navigation_content/library.dart';
import 'package:novelglide/ui/pages/main/layout/navigation_content/settings.dart';

import '../bloc/navigation.dart';

class MainPageBodyWidget extends StatelessWidget {
  const MainPageBodyWidget({super.key});

  final List<Widget> _widgetOptions = const <Widget>[
    LibraryWidget(),
    BookmarkWidget(),
    SettingsWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        child: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return _widgetOptions[state.index];
            }));
  }
}