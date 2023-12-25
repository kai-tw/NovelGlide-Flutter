import 'package:flutter/material.dart';
import 'bookmarks.dart';
import 'library.dart';
import 'settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    LibraryWidget(),
    BookmarkWidget(),
    SettingsWidget()
  ];
  static const List<String> _widgetTitle = <String>[
    'NovelGlide',
    'Bookmarks',
    'Settings'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _titleWidget(),
        body: bodyWidget(),
        bottomNavigationBar: navWidget());
  }

  PreferredSizeWidget _titleWidget() {
    return AppBar(
      title: Text(_widgetTitle[_currentPageIndex]),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  Widget bodyWidget() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: _widgetOptions[_currentPageIndex],
    );
  }

  Widget navWidget() {
    return Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: NavigationBar(
            height: 64.0,
            onDestinationSelected: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            indicatorColor: Colors.transparent,
            selectedIndex: _currentPageIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: const <Widget>[
              NavigationDestination(icon: Icon(Icons.home_outlined), label: ''),
              NavigationDestination(icon: Icon(Icons.bookmark), label: ''),
              NavigationDestination(icon: Icon(Icons.settings), label: '')
            ],
          ),
        ));
  }
}
