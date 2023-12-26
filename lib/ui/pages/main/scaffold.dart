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
        body: _bodyWidget(),
        bottomNavigationBar: _navWidget());
  }

  PreferredSizeWidget _titleWidget() {
    return AppBar(
      title: Text(_widgetTitle[_currentPageIndex]),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  Widget _bodyWidget() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: _widgetOptions[_currentPageIndex],
    );
  }

  Widget _navWidget() {
    return NavigationBar(
      height: 64.0,
      onDestinationSelected: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      indicatorColor: Colors.transparent,
      selectedIndex: _currentPageIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: Theme.of(context).colorScheme.background,
      destinations: const <Widget>[
        NavigationDestination(icon: Icon(Icons.home_outlined), label: ''),
        NavigationDestination(icon: Icon(Icons.bookmark), label: ''),
        NavigationDestination(icon: Icon(Icons.settings), label: '')
      ],
    );
  }
}
