import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/features/book_form/bloc/form_bloc.dart';
import 'package:novelglide/features/book_form/layout/main.dart';

import 'bloc/navigation_bloc.dart';

class HomepageFab extends StatelessWidget {
  const HomepageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: state.showFab ? Offset.zero : const Offset(2, 0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: state.showFab ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () => _onPressed(context),
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(_routeToAddBookPage()).then((_) {
      BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.bookshelf);
    });
  }

  Route _routeToAddBookPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const BookFormPage(BookFormType.add),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        Animatable<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
