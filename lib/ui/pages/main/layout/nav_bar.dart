import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/library_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation_bloc.dart';

class MainPageNavBar extends StatelessWidget {
  const MainPageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(builder: (context, state) {
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
            if (state.index == index) {
              return;
            }
            BlocProvider.of<LibraryBookListCubit>(context).clearSelect(BlocProvider.of<LibraryBookListCubit>(context).state);
            switch (index) {
              case 0:
                BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.library);
                BlocProvider.of<LibraryBookListCubit>(context).refresh();
                break;
              case 1:
                BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.bookmark);
                break;
              case 2:
                BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.settings);
                break;
            }
          });
    });
  }
}
