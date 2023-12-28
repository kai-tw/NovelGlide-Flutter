import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    List<String> widgetTitle = <String>[
      AppLocalizations.of(context)!.app_name,
      AppLocalizations.of(context)!.title_bookmarks,
      AppLocalizations.of(context)!.title_settings
    ];
    return Scaffold(
        appBar: _titleWidget(widgetTitle[_currentPageIndex]),
        body: _bodyWidget(),
        bottomNavigationBar: _navWidget());
  }

  PreferredSizeWidget _titleWidget(title) {
    return AppBar(
      title: Text(title, textAlign: TextAlign.left),
      backgroundColor: Theme.of(context).colorScheme.background
    );
  }

  Widget _bodyWidget() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: _widgetOptions[_currentPageIndex]
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
        NavigationDestination(icon: Icon(Icons.home_filled), label: ''),
        NavigationDestination(icon: Icon(Icons.bookmark), label: ''),
        NavigationDestination(icon: Icon(Icons.settings), label: '')
      ]
    );
  }
}
