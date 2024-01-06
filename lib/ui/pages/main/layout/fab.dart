import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/add_book/layout/main.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation.dart';

class MainPageFab extends StatelessWidget {
  const MainPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(builder: (context, state) {
      return AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: state.showFab ? Offset.zero : const Offset(2, 0),
          child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: state.showFab ? 1 : 0,
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(_routeToAddBookPage()).then((_) {
                      BlocProvider.of<LibraryBookListCubit>(context).refresh();
                    });
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary))));
    });
  }

  Route _routeToAddBookPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const AddBookPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
