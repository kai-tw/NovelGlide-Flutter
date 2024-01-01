import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/add_book/layout/scaffold.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation.dart';
import 'package:novelglide/ui/pages/main/layout/bookmarks.dart';
import 'package:novelglide/ui/pages/main/layout/library.dart';
import 'package:novelglide/ui/pages/main/layout/settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _widgetOptions = const <Widget>[
    LibraryWidget(),
    BookmarkWidget(),
    SettingsWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NavigationCubit(),
        child: Scaffold(
            appBar: _appBar(),
            body: _bodyWidget(),
            floatingActionButton: _floatingActionButton(),
            bottomNavigationBar: _navWidget()));
  }

  PreferredSizeWidget _appBar() {
    final List<String> titleList = [
      AppLocalizations.of(context)!.app_name,
      AppLocalizations.of(context)!.title_bookmarks,
      AppLocalizations.of(context)!.title_settings
    ];
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Align(
            alignment: Alignment.centerLeft,
            child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
              return Text(titleList[state.index]);
            })));
  }

  Widget _bodyWidget() {
    return Container(
        margin: const EdgeInsets.all(8.0),
        child: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
          return _widgetOptions[state.index];
        }));
  }

  Widget _navWidget() {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return NavigationBar(
          height: 64.0,
          selectedIndex: state.index,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Theme.of(context).colorScheme.background,
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home_filled), label: ''),
            NavigationDestination(icon: Icon(Icons.bookmark), label: ''),
            NavigationDestination(icon: Icon(Icons.settings), label: '')
          ],
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                BlocProvider.of<NavigationCubit>(context)
                    .setItem(NavigationItem.library);
                break;
              case 1:
                BlocProvider.of<NavigationCubit>(context)
                    .setItem(NavigationItem.bookmark);
                break;
              case 2:
                BlocProvider.of<NavigationCubit>(context)
                    .setItem(NavigationItem.settings);
                break;
            }
          });
    });
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        onPressed: _floatingActionButtonPressed, child: const Icon(Icons.add));
  }

  void _floatingActionButtonPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddBookPage()));
  }
}
